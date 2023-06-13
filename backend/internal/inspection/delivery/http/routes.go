package http

import (
	"backend/config"
	"backend/internal/auth"
	"backend/internal/inspection"
	"backend/internal/middleware"
	"github.com/gofiber/fiber/v2"
)

func MapInspectionRoutes(inspectionRouter fiber.Router, h inspection.Handlers, mw *middleware.MiddlewareManager, authService auth.Service, cfg *config.Config) {
	inspectionRouter.Use(mw.AuthJWTMiddleware(authService, cfg)) // các url dưới này sẽ dùng middle jwt

	inspectionRouter.Get("/all", h.GetAll())
	inspectionRouter.Get("/inspection/:inspection_id", h.GetByID())
	inspectionRouter.Get("/station/:station_code", h.GetByStationCode())
	inspectionRouter.Get("/registration/:registration_id", h.GetByRegistrationID())
	inspectionRouter.Post("/", h.Create())
	inspectionRouter.Put("/:inspection_id", h.Update())
	inspectionRouter.Delete("/:inspection_id", h.Delete())
	inspectionRouter.Get("/expiry-date", h.GetByExpiryDate())
	inspectionRouter.Get("/inspection-date", h.GetByInspectionDate())
	inspectionRouter.Get("/statistic/", h.CountByQuarterAndYear())
	inspectionRouter.Get("/statistic/all", h.CountAllByQuarterAndYear())
	inspectionRouter.Get("/statistic/region", h.CountAllByRegionAndYear())

}
