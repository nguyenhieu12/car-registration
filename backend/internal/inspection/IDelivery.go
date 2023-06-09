package inspection

import (
	"github.com/gofiber/fiber/v2"
)

type Handlers interface {
	GetAll() fiber.Handler
	GetByID() fiber.Handler
	GetByStationCode() fiber.Handler
	GetByRegistrationID() fiber.Handler

	GetByInspectionDate() fiber.Handler
	GetByExpiryDate() fiber.Handler

	Create() fiber.Handler
	Update() fiber.Handler
	Delete() fiber.Handler
	CountByQuarterAndYear() fiber.Handler
	CountAllByQuarterAndYear() fiber.Handler
	CountAllByRegionAndYear() fiber.Handler
	CountAllByQuarterAndYearInStation() fiber.Handler
}
