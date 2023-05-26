package auth

import (
	"backend/internal/models"
	"backend/pkg/utils"
	"context"
	"github.com/google/uuid"
)

// UseCase Auth repository interface
type Service interface {
	Register(ctx context.Context, user *models.User) (*models.UserWithToken, error)
	Login(ctx context.Context, user *models.User) (*models.UserWithToken, error)
	Update(ctx context.Context, user *models.User) (*models.User, error)
	Delete(ctx context.Context, userID uuid.UUID) error
	GetByID(ctx context.Context, userID uuid.UUID) (*models.User, error)
	FindByUsername(ctx context.Context, name string, query *utils.PaginationQuery) (*models.User, error)
	FindByStationCode(ctx context.Context, stationCode string) (*models.UsersList, error)
	FindByEmail(ctx context.Context, user *models.User) (*models.User, error)
	GetUsers(ctx context.Context, pq *utils.PaginationQuery) (*models.UsersList, error)
}
