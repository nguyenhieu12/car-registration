package http

import (
	"backend/config"
	"backend/internal/inspection"
	"backend/internal/models"
	"backend/pkg/httpErrors"
	"backend/pkg/logger"
	"backend/pkg/utils"
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

// CountAllByQuarterAndYearInStation godoc
// @Summary Count inspections by quarter and year in station
// @Description Count inspections by quarter and year in station
// @Param Authorization header string true "Insert your access token" default(Bearer <Add access token here>)
// @Tags insp
// @Success 200 {object} models.StationQuarterAndYear
// @Router /insp/statistic/station/{station_code} [get]
func (i *inspectionHandlers) CountAllByQuarterAndYearInStation() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.CountAllByQuarterAndYear")
		defer span.Finish()
		//staCode := ctx.Params("station_code")

		var result []models.StationQuarterAndYear
		result, err := i.inspectionService.CountAllByQuarterAndYearInStation(customContext)

		if err != nil {
			i.logger.Error("inspectionHandlers.CountAllByQuarterAndYear.Query", err)
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

// CountAllByRegionAndYear godoc
// @Summary Count inspections by region and year
// @Description Count inspections by region and year
// @Tags insp
// @Accept json
// @Success 200 {object} models.RegionAndYear
// @Router /insp/statistic/region [get]
func (i *inspectionHandlers) CountAllByRegionAndYear() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.CountAllByRegionAndYear")
		defer span.Finish()

		var result []models.RegionAndYear
		result, err := i.inspectionService.CountAllByRegionAndYear(customContext)

		if err != nil {
			i.logger.Error("inspectionHandlers.CountAllByRegionAndYear.Query", err)
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

// CountAllByQuarterAndYear godoc
// @Summary Count inspections by quarter and year
// @Description Count inspections by quarter and year
// @Tags insp
// @Accept json
// @Produce json
// @Success 200 {object} models.QuarterAndYear
// @Router /insp/statistic/all [get]
func (i *inspectionHandlers) CountAllByQuarterAndYear() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.CountAllByQuarterAndYear")
		defer span.Finish()

		var result []models.QuarterAndYear
		result, err := i.inspectionService.CountAllByQuarterAndYear(customContext)

		if err != nil {
			i.logger.Error("inspectionHandlers.CountAllByQuarterAndYear.Query", err)
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

// CountByQuarterAndYear godoc
// @Summary Count inspections by quarter and year
// @Description Count inspections by quarter and year
// @Tags insp
// @Accept json
// @Produce json
// @Param year query int true "Year"
// @Success 200 {object} models.QuarterAndYear
// @Router /insp/statistic [get]
func (i *inspectionHandlers) CountByQuarterAndYear() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.CountByQuarterAndYear")
		defer span.Finish()

		year, err := strconv.Atoi(ctx.Query("year"))
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByID.Query", err)
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request. Ins ID is not valid",
				"message": httpErrors.BadQueryParams.Error(),
			})
		}

		//paginationQuery, err := utils.GetPaginationFromCtx(ctx)
		//if err != nil {
		//	i.logger.Error("inspectionHandlers.GetByInspectionDate.GetPG", err)
		//	return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
		//		"status":  "Internal Server Error",
		//		"message": err.Error(),
		//	})
		//}
		var result models.QuarterAndYear
		result.Year = year
		result.CarsCount.Q1, err = i.inspectionService.CountByQuarterAndYear(customContext, 1, year)
		result.CarsCount.Q2, err = i.inspectionService.CountByQuarterAndYear(customContext, 2, year)
		result.CarsCount.Q3, err = i.inspectionService.CountByQuarterAndYear(customContext, 3, year)
		result.CarsCount.Q4, err = i.inspectionService.CountByQuarterAndYear(customContext, 4, year)
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByInspectionDate.GetByInspectionDate", err)
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

// GetByInspectionDate godoc
// @Summary Get inspections by inspection date
// @Description Get inspections by inspection date
// @Tags insp
// @Accept json
// @Produce json
// @Param month query int true "Month"
// @Param year query int true "Year"
// @Success 200 {object} models.InspectionsList
// @Router /insp/inspection-date [get]
func (i *inspectionHandlers) GetByInspectionDate() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.GetByInspectionDate")
		defer span.Finish()

		month, _ := strconv.Atoi(ctx.Query("month"))
		year, _ := strconv.Atoi(ctx.Query("year"))
		//fmt.Println(month, year)
		//if err != nil {
		//	i.logger.Error("inspectionHandlers.GetByID.Query", err)
		//	return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
		//		"status":  "Bad Request. Ins ID is not valid",
		//		"message": httpErrors.BadQueryParams.Error(),
		//	})
		//}

		paginationQuery, err := utils.GetPaginationFromCtx(ctx)
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByInspectionDate.GetPG", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		inspec, err := i.inspectionService.GetByInspectionDate(customContext, month, year, paginationQuery)
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByInspectionDate.GetByInspectionDate", err)
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

// GetByExpiryDate godoc
// @Summary Get inspections by expiry date
// @Description Get inspections by expiry date
// @Tags insp
// @Accept json
// @Produce json
// @Param month query int true "Month"
// @Param year query int true "Year"
// @Success 200 {object} models.Inspection
// @Router /insp/expiry-date [get]
func (i *inspectionHandlers) GetByExpiryDate() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.GetByExpiryDate")
		defer span.Finish()

		month, _ := strconv.Atoi(ctx.Query("month"))
		year, _ := strconv.Atoi(ctx.Query("year"))
		//fmt.Println(month, year)
		//if err != nil {
		//	i.logger.Error("inspectionHandlers.GetByID.Query", err)
		//	return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
		//		"status":  "Bad Request. Ins ID is not valid",
		//		"message": httpErrors.BadQueryParams.Error(),
		//	})
		//}

		paginationQuery, err := utils.GetPaginationFromCtx(ctx)
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByExpiryDate.GetPG", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		inspec, err := i.inspectionService.GetByExpiryDate(customContext, month, year, paginationQuery)
		if err != nil {
			i.logger.Error("inspectionHandlers.GetByExpiryDate.GetByExpiryDate", err)
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

// GetAll godoc
//
//	@ID				GetAll
//	@Summary		Get all inspections following pagination query(size, page, orderBy
//	@Description	Get the list of all inspections
//	@Tags			insp
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
		//fmt.Println("user", user)
		//users, err := a.authService.GetUsers(customContext, paginationQuery)
		var inspections *models.InspectionsList
		if *user.Role == "god" || *user.Role == "vr" {
			inspections, err = i.inspectionService.GetAll(customContext, paginationQuery)
		} else {
			//fmt.Println(user.StationCode)
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
//	@Tags			insp
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	models.InspectionsList
//	@Failure		500	{object}	httpErrors.RestError
//	@Router			/insp/{inspection_id} [get]
func (i *inspectionHandlers) GetByID() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "inspectionHandlers.GetByID")
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
// @Tags			insp
// @Accept			json
// @Produce		json
// @Param			station_code	path	string	true	"area code"	Format(station_code)
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
		var inspections *models.InspectionsList

		//if *user.Role == "god" || *user.Role == "vr" {
		//	inspections, err = i.inspectionService.GetAll(customContext, paginationQuery)
		//} else {
		//	inspections, err = i.inspectionService.GetByStationCode(customContext, user.StationCode, paginationQuery)
		//}

		if statCode == "VR" || statCode == "GOD" {
			inspections, err = i.inspectionService.GetAll(customContext, paginationQuery)
		} else {
			inspections, err = i.inspectionService.GetByStationCode(customContext, statCode, paginationQuery)

		}

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
// @Tags			insp
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
// @Tags			insp
// @Accept			json
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
// @Tags			insp
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
// @Tags			insp
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
