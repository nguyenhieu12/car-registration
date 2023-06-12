package http

import (
	"backend/config"
	"backend/internal/auth"
	"backend/internal/middleware"
	"backend/internal/station"
	"github.com/gofiber/fiber/v2"
)

func MapStationRoutes(stationRouter fiber.Router, h station.Handlers, mw *middleware.MiddlewareManager, authService auth.Service, cfg *config.Config) {
	stationRouter.Get("/", h.GetAll())
	stationRouter.Get("/:station_code", h.GetStationByCode())
}
