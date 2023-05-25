package server

import (
	"github.com/gofiber/fiber/v2"
)

// Map Server Handlers
func (s *Server) MapHandlers(f *fiber.App) error {

	f.Get("", func(ctx *fiber.Ctx) error {

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   "hello world",
		})
	})

	return nil
}
