package http

import (
	"backend/config"
	"backend/internal/visitor"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"github.com/gofiber/fiber/v2"
	"github.com/opentracing/opentracing-go"
)

type visitorHandlers struct {
	cfg            *config.Config
	visitorService visitor.Service
	logger         logger.Logger
}

// GetByRegistrationID godoc
// @Summary Get visitor by registration ID
// @Description Get visitor by registration ID
// @Tags visitor
// @Accept json
// @Produce json
// @Param registration_id query string true "Registration ID"
// @Param person_identity_number query string true "Person Identity Number"
// @Success 200 {object} models.Visitor
// @Router /visitor [post]
func (v *visitorHandlers) GetByRegistrationID() fiber.Handler {
	type Payload struct {
		RegistrationID       string `json:"registration_id"`
		PersonIdentityNumber string `json:"person_identity_number"`
	}
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "visitorHandlers.GetByRegistrationID")
		defer span.Finish()
		//regID := ctx.Query("registration_id")

		payload := &Payload{}

		if err := ctx.BodyParser(payload); err != nil {
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": err.Error(),
			})
		}

		_, err := utils.GetPaginationFromCtx(ctx)
		if err != nil {
			v.logger.Error("visitorHandlers.GetByRegistrationID", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		//var visitorRecord *models.Visitor

		visitorRecord, err := v.visitorService.GetByRegistrationID(customContext, payload.RegistrationID, nil)

		if err != nil {
			v.logger.Error("visitorHandlers.GetByRegistrationID.GetByRegistrationID ", err)

			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   visitorRecord,
		})
	}
}

func NewVisitorHandlers(cfg *config.Config, visitorService visitor.Service, log logger.Logger) visitor.Handlers {
	return &visitorHandlers{cfg: cfg, visitorService: visitorService, logger: log}
}
