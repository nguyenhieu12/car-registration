package http

import (
	"backend/config"
	"backend/internal/models"
	"backend/internal/vehicle"
	"backend/internal/vehiclesdetails"
	"backend/pkg/httpErrors"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"github.com/gofiber/fiber/v2"
	"github.com/opentracing/opentracing-go"
)

type vehicleHandlers struct {
	cfg                   *config.Config
	vehicleService        vehicle.Service
	vehicleDetailsService vehiclesdetails.Service
	logger                logger.Logger
}

// GetByRegistrationID godoc
//
// @Summary Get vehicle by registration ID
// @Description Get vehicle information by registration ID
// @Tags Vehicles
// @Accept json
// @Produce json
// @Param registration_id path string true "Registration ID"
// @Success 200 {object} models.Vehicle
// @Failure 500 {object} httpErrors.RestError
// @Router /vehicles/{registration_id} [get]
func (v *vehicleHandlers) GetByRegistrationID() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "vehicleHandlers.GetByRegistrationID")
		defer span.Finish()

		uID := ctx.Params("registration_id")

		result, err := v.vehicleService.GetByRegistrationID(customContext, uID)
		if err != nil {
			v.logger.Error("vehicleHandlers.GetByRegistrationID", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   result,
		})
	}
}

// Create godoc
//
// @Summary Create a new vehicle
// @Description Create a new vehicle with the provided data
// @Tags Vehicles
// @Accept json
// @Produce json
// @Param vehicle body models.Vehicle true "Vehicle object"
// @Success 201 {object} models.Vehicle
// @Failure 400 {object} httpErrors.RestError
// @Failure 500 {object} httpErrors.RestError
// @Router /vehicles [post]
func (v *vehicleHandlers) Create() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "vehicleHandlers.Create")
		defer span.Finish()

		record := &models.Vehicle{}

		if err := ctx.BodyParser(record); err != nil {
			v.logger.Error("vehicleHandlers.Create.BodyParser", err)
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": "Invalid request body",
			})
		}

		result, err := v.vehicleService.Create(customContext, record)
		if err != nil {
			v.logger.Error("vehicleHandlers.Create", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusCreated).JSON(&fiber.Map{
			"status": "success",
			"data":   result,
		})
	}
}

// Update godoc
//
// @Summary Update vehicle
// @Description Update an existing vehicle with the provided data
// @Tags Vehicles
// @Accept json
// @Produce json
// @Param vehicle body models.Vehicle true "Vehicle object"
// @Success 200 {object} models.Vehicle
// @Failure 400 {object} httpErrors.RestError
// @Failure 500 {object} httpErrors.RestError
// @Router /vehicles [put]
func (v *vehicleHandlers) Update() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "vehicleHandlers.Update")
		defer span.Finish()

		iID := ctx.Params("registration_id")
		if iID == "" {
			v.logger.Error("vehicleHandlers.Update.Query", httpErrors.BadQueryParams)
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request. Reg ID is not valid",
				"message": httpErrors.BadQueryParams.Error(),
			})
		}

		// Parse the request body into a models.Vehicle struct
		record := &models.Vehicle{}
		record.RegistrationID = iID

		if err := ctx.BodyParser(record); err != nil {
			v.logger.Error("vehicleHandlers.Update.BodyParser", err)
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": "Invalid request body",
			})
		}

		result, err := v.vehicleService.Update(customContext, record)
		if err != nil {
			v.logger.Error("vehicleHandlers.Update", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   result,
		})
	}
}

// Delete godoc
//
// @Summary Delete vehicle
// @Description Delete an existing vehicle by registration ID
// @Tags Vehicles
// @Accept json
// @Produce json
// @Param registration_id path string true "Registration ID"
// @Success 200
// @Failure 500 {object} httpErrors.RestError
// @Router /vehicles/{registration_id} [delete]
func (v *vehicleHandlers) Delete() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "vehicleHandlers.Delete")
		defer span.Finish()

		uID := ctx.Params("registration_id")

		err := v.vehicleService.Delete(customContext, uID)
		if err != nil {
			v.logger.Error("vehicleHandlers.Delete", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
		})
	}
}

// GetAll godoc
//
// @Summary Get all vehicles
// @Description Get a list of all vehicles
// @Tags Vehicles
// @Accept json
// @Produce json
// @Success 200 {array} models.Vehicle
// @Failure 500 {object} httpErrors.RestError
// @Router /vehicles [get]
func (v *vehicleHandlers) GetAll() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "vehicleHandlers.GetAll")
		defer span.Finish()

		paginationQuery, err := utils.GetPaginationFromCtx(ctx)
		if err != nil {
			v.logger.Error("vehicleHandlers.GetAll.GetPG", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}
		results, err := v.vehicleService.GetAll(customContext, paginationQuery)
		if err != nil {
			v.logger.Error("vehicleHandlers.GetAll", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   results,
		})
	}
}

// GetDetailsByRegistrationID godoc
//
// @Summary Get vehicle details by registration ID
// @Description Get vehicle details information by registration ID
// @Tags Vehicles
// @Accept json
// @Produce json
// @Param registration_id path string true "Registration ID"
// @Success 200 {object} models.VehiclesAndDetails
// @Failure 500 {object} httpErrors.RestError
// @Router /vehicle-details/{registration_id} [get]
func (v *vehicleHandlers) GetDetailsByRegistrationID() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "vehicleHandlers.GetDetailsByRegistrationID")
		defer span.Finish()

		uID := ctx.Params("registration_id")

		r1, err := v.vehicleService.GetByRegistrationID(customContext, uID)
		if err != nil {
			v.logger.Error("vehicleHandlers.GetDetailsByRegistrationID.r1", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		r2, err := v.vehicleDetailsService.GetByVinID(customContext, r1.VinID)
		if err != nil {
			v.logger.Error("vehicleHandlers.GetDetailsByRegistrationID.r2", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}
		result := models.VehiclesAndDetails{
			Vehicle:        r1,
			VehicleDetails: r2,
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   result,
		})
	}
}

func NewVehicleHandlers(cfg *config.Config, vehicleService vehicle.Service, vehicleDetailsService vehiclesdetails.Service, log logger.Logger) vehicle.Handlers {
	return &vehicleHandlers{cfg: cfg, vehicleService: vehicleService, vehicleDetailsService: vehicleDetailsService, logger: log}
}
