package owner

import (
	"backend/internal/models"
	"context"
)

type Repository interface {
	GetByPersonIdentityNumber(ctx context.Context, personID string) (*models.Owner, error)
	GetByTaxIdentityNumber(ctx context.Context, taxID string) (*models.Owner, error)
	Create(ctx context.Context, owner *models.Owner) (*models.Owner, error)
	Update(ctx context.Context, owner *models.Owner) (*models.Owner, error)
	Delete(ctx context.Context, ownerID int) error
}
