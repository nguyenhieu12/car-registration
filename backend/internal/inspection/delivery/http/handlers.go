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

// Insp Handlers
type inspectionHandlers struct {
	cfg               *config.Config
	inspectionService inspection.Service
	logger            logger.Logger
}

// GetAll godoc
//
//	@ID				GetAll
//	@Summary		Get all inspections following pagination query(size, page, orderBy
//	@Description	Get the list of all inspections
//	@Tags			Insp
//	@Accept			json
//	@Param			page	query	int	false	"page number"					Format(page)
//	@Param			size	query	int	false	"number of elements per page"	Format(size)
//	@Param			orderBy	query	int	false	"filter name"					Format(orderBy)
//	@Produce		json
//	@Success		200	{object}	models.InspectionsList
//	@Failure		500	{object}	httpErrors.RestError
//	@Router			/insp/all [get]
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
		if *user.Role == "god" || *user.Role == "vr" {
			inspections, err = i.inspectionService.GetAll(customContext, paginationQuery)
		} else {
			inspections, err = i.inspectionService.GetByStationCode(customContext, user.StationCode, paginationQuery)
		}

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

// GetByID godoc
//
//	@ID				GetByID
//	@Summary		Get inspection by ID
//	@Description	Get inspection by ID
//	@Tags			Insp
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	models.InspectionsList
//	@Failure		500	{object}	httpErrors.RestError
//	@Router			/insp/{inspection_id} [get]
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

// GetByStationCode godoc
// @ID				GetByStationCode
// @Summary		Get inspection by station code
// @Description	Get inspection by station code
// @Tags			Insp
// @Accept			json
// @Produce		json
// @Param			station_code	path	string	true	"station code"	Format(station_code)
// @Success		200	{object}	models.InspectionsList
// @Failure		500	{object}	httpErrors.RestError
// @Router			/insp/station/{station_code} [get]
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

// GetByRegistrationID godoc
// @ID				GetByRegistrationID
// @Summary		Get inspection by registration id
// @Description	Get inspection by registration id
// @Tags			Insp
// @Accept			json
// @Produce		json
// @Param			registration_id	path	string	true	"registration id"	Format(registration_id)
// @Success		200	{object}	models.InspectionsList
// @Failure		500	{object}	httpErrors.RestError
// @Router			/insp/registration/{registration_id} [get]
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

// Create godoc
// @ID				Create inspection
// @Summary			Create inspection
// @Description		Create inspection
// @Tags			Insp
// @Accept			json
// @Produce		json
// @Param			user_id	path	string	true	"user id"	Format(user_id)
// @Success		200	{object}	models.Inspection
// @Failure		500	{object}	httpErrors.RestError
// @Router			/insp/ [post]
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

// Update godoc
// @ID				Update
// @Summary		Update inspection
// @Description	Update inspection
// @Tags			Insp
// @Accept			json
// @Produce		json
// @Param			inspection_id	path	string	true	"inspection id"	Format(inspection_id)
// @Success		200	{object}	models.Inspection
// @Failure		500	{object}	httpErrors.RestError
// @Router			/insp/{inspection_id} [put]
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

// Delete godoc
// @ID				Delete
// @Summary		Delete inspection
// @Description	Delete inspection
// @Tags			Insp
// @Accept			json
// @Produce		json
// @Param			inspection_id	path	string	true	"inspection id"	Format(inspection_id)
// @Success		200	{object}	string
// @Failure		500	{object}	httpErrors.RestError
// @Router			/insp/{inspection_id} [delete]
func (i *inspectionHandlers) Delete() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		return nil
	}
}

// NewInspectionHandlers returns a new inspection handlers instance
func NewInspectionHandlers(cfg *config.Config, inspectionService inspection.Service, log logger.Logger) inspection.Handlers {
	return &inspectionHandlers{cfg: cfg, inspectionService: inspectionService, logger: log}
}
