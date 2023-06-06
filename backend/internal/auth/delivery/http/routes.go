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
	authRouter.Get("/all", h.GetUsers())
	authRouter.Get("/:user_id", h.GetUserByID())

}
