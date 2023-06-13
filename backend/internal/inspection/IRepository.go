package inspection

import (
	"backend/internal/models"
	"backend/pkg/utils"
	"context"
)

type Repository interface {
	GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.InspectionsList, error)
	GetByID(ctx context.Context, ID int) (*models.Inspection, error)
	GetByStationCode(ctx context.Context, stationCode string, query *utils.PaginationQuery) (*models.InspectionsList, error)
	GetByRegistrationID(ctx context.Context, registrationID string, query *utils.PaginationQuery) (*models.InspectionsList, error)

	GetByInspectionDate(ctx context.Context, month int, year int, query *utils.PaginationQuery) (*models.InspectionsList, error)
	GetByExpiryDate(ctx context.Context, month int, year int, query *utils.PaginationQuery) (*models.InspectionsList, error)

	Create(ctx context.Context, inspection *models.Inspection) (*models.Inspection, error)
	Update(ctx context.Context, inspection *models.Inspection) (*models.Inspection, error)
	Delete(ctx context.Context, ID int) error
	CountByQuarterAndYear(ctx context.Context, quarter int, year int) (int, error)
	CountAllByQuarterAndYear(ctx context.Context) ([]models.QuarterAndYear, error)
	CountAllByRegionAndYear(ctx context.Context) ([]models.RegionAndYear, error)
	CountAllByQuarterAndYearInStation(ctx context.Context) ([]models.StationQuarterAndYear, error)
}
