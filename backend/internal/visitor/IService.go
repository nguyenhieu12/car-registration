package visitor

import (
	"backend/internal/models"
	"backend/pkg/utils"
	"context"
)

type Service interface {
	GetByRegistrationID(ctx context.Context, registrationID string, query *utils.PaginationQuery) (*models.Visitor, error)
}
