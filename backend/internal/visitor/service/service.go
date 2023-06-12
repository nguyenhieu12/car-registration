package service

import (
	"backend/config"
	"backend/internal/models"
	"backend/internal/visitor"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"context"
	"github.com/opentracing/opentracing-go"
)

type visitorService struct {
	cfg         *config.Config
	visitorRepo visitor.Repository
	logger      logger.Logger
}

func (v *visitorService) GetByRegistrationID(ctx context.Context, registrationID string, query *utils.PaginationQuery) (*models.Visitor, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "visitorService.GetByRegistrationID")
	defer span.Finish()

	record, err := v.visitorRepo.GetByRegistrationID(ctx, registrationID, nil)
	if err != nil {
		return nil, err
	}

	return record, nil
}

func NewVisitorService(cfg *config.Config, visitorRepo visitor.Repository, log logger.Logger) visitor.Service {
	return &visitorService{cfg: cfg, visitorRepo: visitorRepo, logger: log}
}
