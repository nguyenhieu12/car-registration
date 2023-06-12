package auth

import (
	"github.com/gofiber/fiber/v2"
)

type Handlers interface {
	Register() fiber.Handler
	Login() fiber.Handler
	Logout() fiber.Handler
	Update() fiber.Handler
	Delete() fiber.Handler
	GetUserByID() fiber.Handler
	FindByUsername() fiber.Handler
	FindByStationCode() fiber.Handler
	GetUsers() fiber.Handler
	GetMe() fiber.Handler
	ChangePassword() fiber.Handler
}
