package service

import (
	"backend/config"
	"backend/internal/models"
	"backend/internal/vehiclesdetails"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"context"
	"github.com/opentracing/opentracing-go"
)

type vehiclesdetailsService struct {
	cfg    *config.Config
	repo   vehiclesdetails.Repository
	logger logger.Logger
}

func (v *vehiclesdetailsService) GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.VehicleDetailsList, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehiclesdetailsService.GetAll")
	defer span.Finish()

	record, err := v.repo.GetAll(ctx, query)
	if err != nil {
		return nil, err
	}

	return record, nil
}

func (v *vehiclesdetailsService) GetByVinID(ctx context.Context, vinID string) (*models.VehicleDetails, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehiclesdetailsService.GetByVinID")
	defer span.Finish()

	record, err := v.repo.GetByVinID(ctx, vinID)
	if err != nil {
		return nil, err
	}

	return record, nil
}

func (v *vehiclesdetailsService) Create(ctx context.Context, vehicleDetails *models.VehicleDetails) (*models.VehicleDetails, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehiclesdetailsService.Create")
	defer span.Finish()

	record, err := v.repo.Create(ctx, vehicleDetails)
	if err != nil {
		return nil, err
	}

	return record, nil
}

func (v *vehiclesdetailsService) Update(ctx context.Context, vehicleDetails *models.VehicleDetails) (*models.VehicleDetails, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehiclesdetailsService.Update")
	defer span.Finish()

	record, err := v.repo.Update(ctx, vehicleDetails)
	if err != nil {
		return nil, err
	}

	return record, nil
}

func (v *vehiclesdetailsService) Delete(ctx context.Context, vinID string) error {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehiclesdetailsService.Delete")
	defer span.Finish()

	err := v.repo.Delete(ctx, vinID)

	return err
}

func NewVehicleDetailsService(cfg *config.Config, repo vehiclesdetails.Repository, log logger.Logger) vehiclesdetails.Service {
	return &vehiclesdetailsService{cfg: cfg, repo: repo, logger: log}
}
