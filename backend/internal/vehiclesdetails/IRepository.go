package vehiclesdetails

import (
	"backend/internal/models"
	"backend/pkg/utils"
	"context"
)

type Repository interface {
	GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.VehicleDetailsList, error)
	GetByVinID(ctx context.Context, vinID string) (*models.VehicleDetails, error)
	Create(ctx context.Context, vehicleDetails *models.VehicleDetails) (*models.VehicleDetails, error)
	Update(ctx context.Context, vehicleDetails *models.VehicleDetails) (*models.VehicleDetails, error)
	Delete(ctx context.Context, vinID string) error
}
