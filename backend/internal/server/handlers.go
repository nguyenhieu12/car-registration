package server

import (
	_ "backend/docs"
	authHttp "backend/internal/auth/delivery/http"
	authRepo "backend/internal/auth/repository"
	authServ "backend/internal/auth/service"
	apiMiddlewares "backend/internal/middleware"
	"backend/pkg/utils"
	"github.com/ansrivas/fiberprometheus/v2"
	fiberSwagger "github.com/arsmn/fiber-swagger/v2"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/gofiber/fiber/v2/middleware/favicon"
	"github.com/gofiber/fiber/v2/middleware/limiter"
	"github.com/gofiber/fiber/v2/middleware/requestid"
	"github.com/opentracing/opentracing-go"
)

// MapHandlers Map Server Handlers
func (s *Server) MapHandlers(f *fiber.App) error {

	// Init repositories
	authRepository := authRepo.NewAuthRepository(s.db)

	// Init services
	authService := authServ.NewAuthService(s.cfg, authRepository, s.logger)

	// Init handlers
	authHandlers := authHttp.NewAuthHandlers(s.cfg, authService, s.logger)

	// Init middleware manager
	mw := apiMiddlewares.NewMiddlewareManager(authService, s.cfg, []string{"*"}, s.logger)

	// Use default middleware of fiber
	f.Use(requestid.New()) // default is "X-Request-ID"
	f.Use(favicon.New())
	f.Use(limiter.New(limiter.Config{
		Max: 1000,
		LimitReached: func(c *fiber.Ctx) error {
			return c.Status(fiber.StatusTooManyRequests).JSON(&fiber.Map{
				"status":  "fail",
				"message": "You have requested too many in a single time-frame! Please wait another minute!",
			})
		},
	}))

	f.Use(cors.New())

	//logger, _ := zap.NewProduction()
	//
	//f.Use(fiberzap.New(fiberzap.Config{
	//	Logger: logger,
	//}))

	prometheus := fiberprometheus.New("my-prometheus")
	prometheus.RegisterAt(f, "/metrics")
	f.Use(prometheus.Middleware)

	// Document route
	swaggerRoute := f.Group("/swagger")
	swaggerRoute.Get("*", fiberSwagger.HandlerDefault)

	// API version v1
	v1 := f.Group("/api/v1")
	health := v1.Group("/health")
	authGroup := v1.Group("/auth")

	authHttp.MapAuthRoutes(authGroup, authHandlers, mw, authService, s.cfg)

	health.Get("", func(ctx *fiber.Ctx) error {
		s.logger.Infof("Health check RequestID: %s", utils.GetRequestID(ctx))
		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "OK",
		})
	})

	f.Get("", func(ctx *fiber.Ctx) error {
		span, _ := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "example.start")
		defer span.Finish()

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   "hello world",
		})
	})

	f.Get("/hi", func(ctx *fiber.Ctx) error {
		span, _ := opentracing.StartSpanFromContext(ctx.Context(), "num.end")
		defer span.Finish()

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   "hii",
		})
	})

	f.Use(func(c *fiber.Ctx) error {
		return c.Status(fiber.StatusNotFound).SendString("Sorry can't find that!")
	})

	return nil
}
