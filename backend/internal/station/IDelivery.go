package station

import (
	"github.com/gofiber/fiber/v2"
)

type Handlers interface {
	GetStationByCode() fiber.Handler
	GetAll() fiber.Handler
}
