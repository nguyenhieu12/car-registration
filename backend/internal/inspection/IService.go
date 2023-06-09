package inspection

import (
	"backend/internal/models"
	"backend/pkg/utils"
	"context"
)

type Service interface {
	GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.InspectionsList, error)
	GetByID(ctx context.Context, ID int) (*models.Inspection, error)
	GetByStationCode(ctx context.Context, stationCode string, query *utils.PaginationQuery) (*models.InspectionsList, error)
	GetByRegistrationID(ctx context.Context, registrationID string, query *utils.PaginationQuery) (*models.InspectionsList, error)
	Create(ctx context.Context, inspection *models.Inspection) (*models.Inspection, error)
	Update(ctx context.Context, inspection *models.Inspection) (*models.Inspection, error)
	Delete(ctx context.Context, ID int) error
}
