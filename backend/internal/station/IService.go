package station

import (
	"backend/internal/models"
	"backend/pkg/utils"
	"context"
)

type Service interface {
	GetStationByCode(ctx context.Context, code string) (*models.Station, error)
	GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.StationsList, error)
}
