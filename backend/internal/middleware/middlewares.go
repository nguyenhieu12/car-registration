package middleware

import (
	"backend/config"
	"backend/internal/auth"
	"backend/pkg/logger"
)

// MiddlewareManager Middleware manager
type MiddlewareManager struct {
	//sessUC  session.UCSession
	authService auth.Service
	cfg         *config.Config
	origins     []string
	logger      logger.Logger
}

// Middleware manager constructor
func NewMiddlewareManager(authService auth.Service, cfg *config.Config, origins []string, logger logger.Logger) *MiddlewareManager {
	return &MiddlewareManager{authService: authService, cfg: cfg, origins: origins, logger: logger}
}
