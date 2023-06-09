package http

import (
	"backend/config"
	"backend/internal/inspection"
	"backend/internal/models"
	"backend/pkg/httpErrors"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"fmt"
	"github.com/gofiber/fiber/v2"
	"github.com/opentracing/opentracing-go"
	"strconv"
)

type inspectionHandlers struct {
	cfg               *config.Config
	inspectionService inspection.Service
	logger            logger.Logger
}

func (i *inspectionHandlers) GetAll() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.GetAll")
		defer span.Finish()

		paginationQuery, err := utils.GetPaginationFromCtx(ctx)
		if err != nil {
			i.logger.Error("inspectionHandlers.GetAll", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}
		user := ctx.Locals("user").(*models.User)
		fmt.Println("user", user)
		//users, err := a.authService.GetUsers(customContext, paginationQuery)
		var inspections *models.InspectionsList
		//if *user.Role == "god" || *user.Role == "vr" {
		inspections, err = i.inspectionService.GetAll(customContext, paginationQuery)
		//
		//} else {
		//	inspections, err = i.inspectionService.GetByStationCode(customContext, user.StationCode, paginationQuery)
		//}

		if err != nil {
			i.logger.Error("inspectionHandlers.GetAll.GetByRole ", err)

			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   inspections,
		})
	}
}

func (i *inspectionHandlers) GetByID() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "authHandlers.GetByID")
		defer span.Finish()

		uID, err := strconv.Atoi(ctx.Params("inspection_id"))
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByID.Query", err)
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request. Ins ID is not valid",
				"message": httpErrors.BadQueryParams.Error(),
			})
		}

		inspec, err := i.inspectionService.GetByID(customContext, uID)
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByID.GetByID", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   inspec,
		})
	}
}

func (i *inspectionHandlers) GetByStationCode() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.GetByStationCode")
		defer span.Finish()

		paginationQuery, err := utils.GetPaginationFromCtx(ctx)
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByRegistrationID", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}
		statCode := ctx.Params("station_code")
		//inspectionLocals := ctx.Locals("user").(*models.User)

		//users, err := a.authService.GetUsers(customContext, paginationQuery)
		var inspections *models.InspectionsList
		inspections, err = i.inspectionService.GetByStationCode(customContext, statCode, paginationQuery)

		if err != nil {
			i.logger.Error("inspectionHandlers.GetByStationCode.GetByRole ", err)

			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   inspections,
		})
	}
}

func (i *inspectionHandlers) GetByRegistrationID() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.GetByRegistrationID")
		defer span.Finish()

		paginationQuery, err := utils.GetPaginationFromCtx(ctx)
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByRegistrationID", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}
		regID := ctx.Params("registration_id")
		//inspectionLocals := ctx.Locals("user").(*models.User)

		//users, err := a.authService.GetUsers(customContext, paginationQuery)
		var inspections *models.InspectionsList
		inspections, err = i.inspectionService.GetByRegistrationID(customContext, regID, paginationQuery)

		if err != nil {
			i.logger.Error("inspectionHandlers.GetByRegistrationID.GetByRole ", err)

			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   inspections,
		})
	}
}

func (i *inspectionHandlers) Create() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.Create")
		defer span.Finish()

		inspectionRecord := &models.Inspection{}

		if err := ctx.BodyParser(inspectionRecord); err != nil {
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": err.Error(),
			})
		}

		err := utils.ValidateStruct(customContext, inspectionRecord)
		if err != nil {
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": err.Error(),
			})
		}

		createdInsp, err := i.inspectionService.Create(customContext, inspectionRecord)
		if err != nil {
			i.logger.Error("inspectionHandlers.Create ", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusCreated).JSON(&fiber.Map{
			"status": "success",
			"data":   &createdInsp,
		})
	}
}

func (i *inspectionHandlers) Update() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.Update")
		defer span.Finish()

		iID := ctx.Params("inspection_id")
		if iID == "" {
			i.logger.Error("inspectionHandlers.Update.Query", httpErrors.BadQueryParams)
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request. Reg ID is not valid",
				"message": httpErrors.BadQueryParams.Error(),
			})
		}

		inspec := &models.Inspection{}
		inspec.RegistrationID = iID

		if err := ctx.BodyParser(inspec); err != nil {
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": err.Error(),
			})
		}

		updated, err := i.inspectionService.Update(customContext, inspec)
		if err != nil {
			i.logger.Error("inspectionHandlers.Update.Query", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   &updated,
		})
	}
}

func (i *inspectionHandlers) Delete() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		return nil
	}
}

func NewInspectionHandlers(cfg *config.Config, inspectionService inspection.Service, log logger.Logger) inspection.Handlers {
	return &inspectionHandlers{cfg: cfg, inspectionService: inspectionService, logger: log}
}
