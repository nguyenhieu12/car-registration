package http

import (
	"backend/config"
	"backend/internal/auth"
	"backend/internal/middleware"
	"backend/internal/visitor"
	"github.com/gofiber/fiber/v2"
)

func MapVisitorRoutes(visitorRouter fiber.Router, h visitor.Handlers, mw *middleware.MiddlewareManager, authService auth.Service, cfg *config.Config) {
	visitorRouter.Get("/", h.GetByRegistrationID())
}
