package http

import (
	"backend/config"
	"backend/internal/station"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"fmt"
	"github.com/gofiber/fiber/v2"
	"github.com/opentracing/opentracing-go"
)

type stationHandlers struct {
	cfg            *config.Config
	stationService station.Service
	logger         logger.Logger
}

// GetAll godoc
// @Summary Get all stations
// @Description Get all stations
// @Tags station
// @Accept json
// @Produce json
// @Param page query int false "Page number"
// @Param limit query int false "Limit per page"
// @Param sort query string false "Sort by"
// @Param order query string false "Order by"
// @Success 200 {object} models.StationsList
// @Router /station [get]
func (s *stationHandlers) GetAll() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, _ := opentracing.StartSpanFromContext(ctx.Context(), "stationRepo.GetAll")
		defer span.Finish()

		paginationQuery, err := utils.GetPaginationFromCtx(ctx)
		if err != nil {
			s.logger.Error("vehicleHandlers.GetAll.GetPG", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}
		stationRecord, err := s.stationService.GetAll(ctx.Context(), paginationQuery)
		if err != nil {
			return ctx.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": fmt.Sprintf("Failed to get station: %v", err),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   stationRecord,
		})
	}
}

// GetStationByCode godoc
// @Summary Get station by Code
// @Description Get station by Code
// @Tags station
// @Accept json
// @Produce json
// @Param station_id path int true "Station Code"
// @Success 200 {object} models.Station
// @Router /station/{station_code} [get]
func (s *stationHandlers) GetStationByCode() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, _ := opentracing.StartSpanFromContext(ctx.Context(), "stationRepo.GetByID")
		defer span.Finish()

		id := ctx.Params("station_code")
		stationRecord, err := s.stationService.GetStationByCode(ctx.Context(), id)
		if err != nil {
			return ctx.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
				"message": fmt.Sprintf("Failed to get station: %v", err),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   stationRecord,
		})
	}
}

func NewStationHandlers(cfg *config.Config, stationService station.Service, log logger.Logger) station.Handlers {
	return &stationHandlers{cfg: cfg, stationService: stationService, logger: log}
}
