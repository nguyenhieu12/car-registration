package middleware

import (
	"backend/config"
	"backend/internal/auth"
	"backend/pkg/httpErrors"
	"backend/pkg/utils"
	"context"
	"fmt"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"net/http"
	"strings"
)

// AuthJWTMiddleware JWT way of auth using cookie or Authorization header
func (mw *MiddlewareManager) AuthJWTMiddleware(authService auth.Service, cfg *config.Config) fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		bearerHeader := ctx.GetReqHeaders()["Authorization"]
		//bearerHeader := ctx.Request().HeaderGetReqHeaders()["Authorization"]
		mw.logger.Infof("Auth middleware bearerHeader %s", bearerHeader)
		if bearerHeader != "" {
			headerParts := strings.Split(bearerHeader, " ")
			if len(headerParts) != 2 {
				mw.logger.Error("Auth middleware", zap.String("headerParts", "len(headerParts) != 2"))
				return ctx.Status(http.StatusUnauthorized).JSON(httpErrors.NewUnauthorizedError(httpErrors.Unauthorized))
			}

			tokenString := headerParts[1]

			if err := mw.validateJWTToken(tokenString, authService, ctx, cfg); err != nil {
				mw.logger.Error("Middleware validateJWTToken", zap.String("headerJWT", err.Error()))
				return ctx.Status(http.StatusUnauthorized).JSON(httpErrors.NewUnauthorizedError(httpErrors.Unauthorized))
			}

			return ctx.Next()
		}

		return ctx.Status(http.StatusUnauthorized).JSON(httpErrors.NewUnauthorizedError(httpErrors.Unauthorized))
	}
}

func (mw *MiddlewareManager) validateJWTToken(tokenString string, service auth.Service, ctx *fiber.Ctx, cfg *config.Config) error {
	if tokenString == "" {
		return httpErrors.InvalidJWTToken
	}

	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signin method %v", token.Header["alg"])
		}
		secret := []byte(cfg.Server.JwtSecretKey)
		return secret, nil
	})
	if err != nil {
		return err
	}

	if !token.Valid {
		return httpErrors.InvalidJWTToken
	}

	if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
		userID, ok := claims["id"].(string)
		if !ok {
			return httpErrors.InvalidJWTClaims
		}

		userUUID, err := uuid.Parse(userID)
		if err != nil {
			return err
		}

		u, err := service.GetByID(utils.GetRequestCtx(ctx), userUUID)
		if err != nil {
			return err
		}

		ctx.Locals("user", u)

		c := context.WithValue(ctx.Context(), utils.UserCtxKey{}, u)
		ctx.SetUserContext(c)
		//todo
		// req := c.Request().WithContext(ctx)
		//ctx.SetUserContext()SetRequest(c.Request().WithContext(ctx))
	}
	return nil
}
