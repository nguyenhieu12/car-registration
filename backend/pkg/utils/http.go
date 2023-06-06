package utils

import (
	"backend/internal/models"
	"backend/pkg/httpErrors"
	"context"
	"github.com/gofiber/fiber/v2"
	"time"
)

// GetRequestID Get request id from fiber context
func GetRequestID(c *fiber.Ctx) string {
	return c.GetRespHeader("X-Request-Id")
}

// ReqIDCtxKey is a key used for the Request ID in context
type ReqIDCtxKey struct{}

// GetCtxWithReqID Get ctx with timeout and request id from echo context
func GetCtxWithReqID(c *fiber.Ctx) (context.Context, context.CancelFunc) {
	ctx, cancel := context.WithTimeout(c.Context(), time.Second*15)
	ctx = context.WithValue(ctx, ReqIDCtxKey{}, GetRequestID(c))
	return ctx, cancel
}

// GetRequestCtx Get context  with request id
func GetRequestCtx(c *fiber.Ctx) context.Context {
	return context.WithValue(c.Context(), ReqIDCtxKey{}, GetRequestID(c))
}

// GetConfigPath Get config path for local or docker
func GetConfigPath(configPath string) string {
	if configPath == "docker" {
		return "./config/config-docker"
	}
	return "./config/config-local"
}

// UserCtxKey is a key used for the User object in the context
type UserCtxKey struct{}

// GetUserFromCtx Get user from context
func GetUserFromCtx(ctx context.Context) (*models.User, error) {
	user, ok := ctx.Value(UserCtxKey{}).(*models.User)
	if !ok {
		return nil, httpErrors.Unauthorized
	}

	return user, nil
}
