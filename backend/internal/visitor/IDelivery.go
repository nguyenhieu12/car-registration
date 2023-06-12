package visitor

import "github.com/gofiber/fiber/v2"

type Handlers interface {
	GetByRegistrationID() fiber.Handler
}
