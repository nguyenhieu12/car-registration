package server

import (
	_ "backend/docs"
	authHttp "backend/internal/auth/delivery/http"
	authRepo "backend/internal/auth/repository"
	authServ "backend/internal/auth/service"

	inspHttp "backend/internal/inspection/delivery/http"
	inspRepo "backend/internal/inspection/repository"
	inspServ "backend/internal/inspection/service"

	vehHttp "backend/internal/vehicle/delivery/http"
	vehRepo "backend/internal/vehicle/repository"
	vehServ "backend/internal/vehicle/service"

	vehDeRepo "backend/internal/vehiclesdetails/repository"
	vehDeServ "backend/internal/vehiclesdetails/service"

	visitHttp "backend/internal/visitor/delivery/http"
	visitRepo "backend/internal/visitor/repository"
	visitServ "backend/internal/visitor/service"

	staHttp "backend/internal/station/delivery/http"
	staRepo "backend/internal/station/repository"
	staServ "backend/internal/station/service"

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
	inspRepository := inspRepo.NewInspectionRepository(s.db)
	vehRepository := vehRepo.NewVehicleRepository(s.db)
	vehDeRepository := vehDeRepo.NewVehicleDetailsRepository(s.db)
	visitRepository := visitRepo.NewVisitorRepository(s.db)
	staRepository := staRepo.NewRepository(s.db)

	// Init services
	authService := authServ.NewAuthService(s.cfg, authRepository, s.logger)
	inspService := inspServ.NewInspectionService(s.cfg, inspRepository, s.logger)
	vehService := vehServ.NewVehicleService(s.cfg, vehRepository, s.logger)
	vehDeService := vehDeServ.NewVehicleDetailsService(s.cfg, vehDeRepository, s.logger)
	visitService := visitServ.NewVisitorService(s.cfg, visitRepository, s.logger)
	staService := staServ.NewStationService(s.cfg, staRepository, s.logger)

	// Init handlers
	authHandlers := authHttp.NewAuthHandlers(s.cfg, authService, s.logger)
	inspHandlers := inspHttp.NewInspectionHandlers(s.cfg, inspService, s.logger)
	vehHandlers := vehHttp.NewVehicleHandlers(s.cfg, vehService, vehDeService, s.logger)
	visitHandlers := visitHttp.NewVisitorHandlers(s.cfg, visitService, s.logger)
	staHandlers := staHttp.NewStationHandlers(s.cfg, staService, s.logger)

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
	inspectionGroup := v1.Group("/insp")
	vehGroup := v1.Group("/vehicle")
	visitGroup := v1.Group("/visitor")
	staGroup := v1.Group("/station")

	authHttp.MapAuthRoutes(authGroup, authHandlers, mw, authService, s.cfg)
	inspHttp.MapInspectionRoutes(inspectionGroup, inspHandlers, mw, authService, s.cfg)
	vehHttp.MapAuthRoutes(vehGroup, vehHandlers, mw, authService, s.cfg)
	visitHttp.MapVisitorRoutes(visitGroup, visitHandlers, mw, authService, s.cfg)
	staHttp.MapStationRoutes(staGroup, staHandlers, mw, authService, s.cfg)

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
