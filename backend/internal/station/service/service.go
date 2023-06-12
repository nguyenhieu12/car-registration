package service

import (
	"backend/config"
	"backend/internal/models"
	"backend/internal/station"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"context"
	"fmt"
	"github.com/opentracing/opentracing-go"
)

type stationService struct {
	cfg    *config.Config
	repo   station.Repository
	logger logger.Logger
}

func (s *stationService) GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.StationsList, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "stationService.GetAll")
	defer span.Finish()

	record, err := s.repo.GetAll(ctx, query)
	if err != nil {
		return nil, err
	}

	return record, nil
}

func (s *stationService) GetStationByCode(ctx context.Context, code string) (*models.Station, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "stationService.GetStationByID")
	defer span.Finish()
	station, err := s.repo.GetStationByCode(ctx, code)
	if err != nil {
		s.logger.Error(fmt.Sprintf("Failed to get station by ID: %v", err))
		return nil, err
	}
	return station, nil
}

func NewStationService(cfg *config.Config, repo station.Repository, logger logger.Logger) station.Service {
	return &stationService{
		cfg:    cfg,
		repo:   repo,
		logger: logger,
	}
}
