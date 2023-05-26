package http

import (
	"backend/internal/auth"
	"backend/internal/middleware"
	"github.com/gofiber/fiber/v2"
)

func MapAuthRoutes(authRouter fiber.Router, h auth.Handlers, mw *middleware.MiddlewareManager) {
	authRouter.Post("/register", h.Register())
	authRouter.Get("/all", h.GetUsers())
	authRouter.Post("/login", h.Login())
}
