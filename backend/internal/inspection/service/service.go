package service

import (
	"backend/config"
	"backend/internal/inspection"
	"backend/internal/models"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"context"
	"github.com/opentracing/opentracing-go"
)

type inspectionService struct {
	cfg            *config.Config
	inspectionRepo inspection.Repository
	logger         logger.Logger
}

func (i *inspectionService) CountAllByQuarterAndYear(ctx context.Context) ([]models.QuarterAndYear, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.CountAllByQuarterAndYear")
	defer span.Finish()

	return i.inspectionRepo.CountAllByQuarterAndYear(ctx)
}

func (i *inspectionService) CountByQuarterAndYear(ctx context.Context, quarter int, year int) (int, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.CountByQuarterAndYear")
	defer span.Finish()

	return i.inspectionRepo.CountByQuarterAndYear(ctx, quarter, year)
}

func (i *inspectionService) GetByInspectionDate(ctx context.Context, month int, year int, query *utils.PaginationQuery) (*models.InspectionsList, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.GetByInspectionDate")
	defer span.Finish()

	return i.inspectionRepo.GetByInspectionDate(ctx, month, year, query)
}

func (i *inspectionService) GetByExpiryDate(ctx context.Context, month int, year int, query *utils.PaginationQuery) (*models.InspectionsList, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.GetByExpiryDate")
	defer span.Finish()

	return i.inspectionRepo.GetByExpiryDate(ctx, month, year, query)
}

func (i *inspectionService) GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.InspectionsList, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.GetAll")
	defer span.Finish()

	return i.inspectionRepo.GetAll(ctx, query)
}

func (i *inspectionService) GetByID(ctx context.Context, ID int) (*models.Inspection, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.GetByID")
	defer span.Finish()

	inspectionRecord, err := i.inspectionRepo.GetByID(ctx, ID)
	if err != nil {
		return nil, err
	}

	return inspectionRecord, nil
}

func (i *inspectionService) GetByStationCode(ctx context.Context, stationCode string, query *utils.PaginationQuery) (*models.InspectionsList, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.GetByStationCode")
	defer span.Finish()

	return i.inspectionRepo.GetByStationCode(ctx, stationCode, query)
}

func (i *inspectionService) GetByRegistrationID(ctx context.Context, registrationID string, query *utils.PaginationQuery) (*models.InspectionsList, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.GetByRegistrationID")
	defer span.Finish()

	return i.inspectionRepo.GetByRegistrationID(ctx, registrationID, query)
}

func (i *inspectionService) Create(ctx context.Context, inspection *models.Inspection) (*models.Inspection, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.Create")
	defer span.Finish()

	createdInspection, err := i.inspectionRepo.Create(ctx, inspection)
	if err != nil {
		return nil, err
	}

	return createdInspection, nil
}

func (i *inspectionService) Update(ctx context.Context, inspection *models.Inspection) (*models.Inspection, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.Update")
	defer span.Finish()

	updatedUser, err := i.inspectionRepo.Update(ctx, inspection)
	if err != nil {
		return nil, err
	}

	return updatedUser, nil
}

func (i *inspectionService) Delete(ctx context.Context, ID int) error {
	span, ctx := opentracing.StartSpanFromContext(ctx, "inspectionService.Update")
	defer span.Finish()

	err := i.inspectionRepo.Delete(ctx, ID)
	return err
}

// NewInspectionService Ins Service constructor
func NewInspectionService(cfg *config.Config, inspectionRepo inspection.Repository, log logger.Logger) inspection.Service {
	return &inspectionService{cfg: cfg, inspectionRepo: inspectionRepo, logger: log}
}
