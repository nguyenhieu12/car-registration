package vehicle

import (
	"backend/internal/models"
	"backend/pkg/utils"
	"context"
)

type Repository interface {
	GetByRegistrationID(ctx context.Context, registrationID string) (*models.Vehicle, error)
	Create(ctx context.Context, vehicle *models.Vehicle) (*models.Vehicle, error)
	Update(ctx context.Context, vehicle *models.Vehicle) (*models.Vehicle, error)
	Delete(ctx context.Context, registrationID string) error
	GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.VehiclesList, error)
	GetDetailsByRegistrationID(ctx context.Context, registrationID string) (*models.VehiclesAndDetails, error)
}
