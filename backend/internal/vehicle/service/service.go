package service

import (
	"backend/config"
	"backend/internal/models"
	"backend/internal/vehicle"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"context"
	"github.com/opentracing/opentracing-go"
)

type vehicleService struct {
	cfg    *config.Config
	repo   vehicle.Repository
	logger logger.Logger
}

func (v *vehicleService) GetDetailsByRegistrationID(ctx context.Context, registrationID string) (*models.VehiclesAndDetails, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehicleService.GetDetailsByRegistrationID")
	defer span.Finish()

	record, err := v.repo.GetDetailsByRegistrationID(ctx, registrationID)
	if err != nil {
		return nil, err
	}

	return record, nil
}

func (v *vehicleService) GetByRegistrationID(ctx context.Context, registrationID string) (*models.Vehicle, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehicleService.GetByRegistrationID")
	defer span.Finish()

	record, err := v.repo.GetByRegistrationID(ctx, registrationID)
	if err != nil {
		return nil, err
	}

	return record, nil
}

func (v *vehicleService) Create(ctx context.Context, vehicle *models.Vehicle) (*models.Vehicle, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehicleService.Create")
	defer span.Finish()

	created, err := v.repo.Create(ctx, vehicle)
	if err != nil {
		return nil, err
	}

	return created, nil
}

func (v *vehicleService) Update(ctx context.Context, vehicle *models.Vehicle) (*models.Vehicle, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehicleService.Update")
	defer span.Finish()

	created, err := v.repo.Update(ctx, vehicle)
	if err != nil {
		return nil, err
	}

	return created, nil
}

func (v *vehicleService) Delete(ctx context.Context, registrationID string) error {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehicleService.Delete")
	defer span.Finish()

	err := v.repo.Delete(ctx, registrationID)
	return err
}

func (v *vehicleService) GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.VehiclesList, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "vehicleService.GetAll")
	defer span.Finish()

	record, err := v.repo.GetAll(ctx, query)
	if err != nil {
		return nil, err
	}

	return record, nil
}

func NewVehicleService(cfg *config.Config, repo vehicle.Repository, log logger.Logger) vehicle.Service {
	return &vehicleService{cfg: cfg, repo: repo, logger: log}
}
