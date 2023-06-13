package http

import (
	"backend/config"
	"backend/internal/auth"
	"backend/internal/middleware"
	"github.com/gofiber/fiber/v2"
)

func MapAuthRoutes(authRouter fiber.Router, h auth.Handlers, mw *middleware.MiddlewareManager, authService auth.Service, cfg *config.Config) {
	authRouter.Post("/register", h.Register())
	authRouter.Post("/login", h.Login())
	authRouter.Use(mw.AuthJWTMiddleware(authService, cfg)) // các url dưới này sẽ dùng middle jwt
	authRouter.Get("/all", mw.GeneralAdmin(), h.GetUsers())
	authRouter.Get("/:user_id", h.GetUserByID())
	authRouter.Put("/:user_id", mw.GeneralAdmin(), h.Update())
	authRouter.Put("/change-password/:user_id", h.ChangePassword())
	authRouter.Delete("/:user_id", mw.GeneralAdmin(), h.Delete())

}
