package http

import (
	"backend/config"
	"backend/internal/auth"
	"backend/internal/middleware"
	"backend/internal/vehicle"
	"github.com/gofiber/fiber/v2"
)

func MapAuthRoutes(vehicleRouter fiber.Router, h vehicle.Handlers, mw *middleware.MiddlewareManager, authService auth.Service, cfg *config.Config) {
	vehicleRouter.Get("/details/:registration_id", h.GetDetailsByRegistrationID())
	vehicleRouter.Get("/:registration_id", h.GetByRegistrationID())
	vehicleRouter.Post("/", h.Create())
	vehicleRouter.Put("/:registration_id", h.Update())
	vehicleRouter.Delete("/:registration_id", h.Delete())
	vehicleRouter.Get("/", h.GetAll())

}
