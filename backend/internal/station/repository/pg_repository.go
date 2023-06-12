package repository

import (
	"backend/internal/models"
	"backend/internal/station"
	"backend/pkg/utils"
	"context"
	"github.com/opentracing/opentracing-go"
	"github.com/pkg/errors"
	"gorm.io/gorm"
)

type stationRepository struct {
	db *gorm.DB
}

func (r *stationRepository) GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.StationsList, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "stationRepository.GetAll")
	defer span.Finish()

	result := r.db.First(&models.Station{})

	totalCount := int(result.RowsAffected)
	if result := r.db.First(&models.Station{}); result.Error != nil {
		return nil, errors.Wrap(result.Error, "vehicleRepo.GetAll.Results")
	}

	if totalCount == 0 {
		return &models.StationsList{
			TotalCount: totalCount,
			TotalPages: utils.GetTotalPages(totalCount, query.GetSize()),
			Page:       query.GetPage(),
			Size:       query.GetSize(),
			HasMore:    utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
			Stations:   make([]*models.Station, 0),
		}, nil
	}

	var record = make([]*models.Station, 0, query.GetSize())
	if records := r.db.Limit(query.GetLimit()).Offset(query.GetOffset()).Order(query.GetOrderBy()).Find(&record); records.Error != nil {
		return nil, errors.Wrap(records.Error, "vehicleRepo.GetAll.Query")
	}

	return &models.StationsList{
		TotalCount: totalCount,
		TotalPages: utils.GetTotalPages(totalCount, query.GetSize()),
		Page:       query.GetPage(),
		Size:       query.GetSize(),
		HasMore:    utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
		Stations:   record,
	}, nil
}

func NewRepository(db *gorm.DB) station.Repository {
	return &stationRepository{
		db: db,
	}
}

func (r *stationRepository) GetStationByCode(ctx context.Context, code string) (*models.Station, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "stationRepo.GetStationByCode")
	defer span.Finish()

	var record models.Station
	if result := r.db.Where("station_code = ?", code).First(&record); result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return nil, nil // Return nil if the record is not found
		}
		return nil, errors.Wrap(result.Error, "stationRepo.GetStationByCode")
	}

	return &record, nil
}
