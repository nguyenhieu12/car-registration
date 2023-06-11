package vehicle

import (
	"github.com/gofiber/fiber/v2"
)

type Handlers interface {
	GetByRegistrationID() fiber.Handler
	Create() fiber.Handler
	Update() fiber.Handler
	Delete() fiber.Handler
	GetAll() fiber.Handler
	GetDetailsByRegistrationID() fiber.Handler
}
