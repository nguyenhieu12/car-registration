package repository

import (
	"backend/internal/models"
	"backend/internal/vehiclesdetails"
	"backend/pkg/utils"
	"context"
	"github.com/opentracing/opentracing-go"
	"github.com/pkg/errors"
	"gorm.io/gorm"
)

type vehicleDetailsRepo struct {
	db *gorm.DB
}

func (v *vehicleDetailsRepo) GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.VehicleDetailsList, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleDetailsRepo.GetAll")
	defer span.Finish()

	result := v.db.First(&models.VehicleDetails{})

	totalCount := int(result.RowsAffected)
	if result := v.db.First(&models.VehicleDetails{}); result.Error != nil {
		return nil, errors.Wrap(result.Error, "vehicleDetailsRepo.GetAll.Results")
	}

	if totalCount == 0 {
		return &models.VehicleDetailsList{
			TotalCount:     totalCount,
			TotalPages:     utils.GetTotalPages(totalCount, query.GetSize()),
			Page:           query.GetPage(),
			Size:           query.GetSize(),
			HasMore:        utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
			VehicleDetails: make([]*models.VehicleDetails, 0),
		}, nil
	}

	var record = make([]*models.VehicleDetails, 0, query.GetSize())
	if records := v.db.Limit(query.GetLimit()).Offset(query.GetOffset()).Order(query.GetOrderBy()).Find(&record); records.Error != nil {
		return nil, errors.Wrap(records.Error, "vehicleDetailsRepo.GetAll.Query")
	}

	return &models.VehicleDetailsList{
		TotalCount:     totalCount,
		TotalPages:     utils.GetTotalPages(totalCount, query.GetSize()),
		Page:           query.GetPage(),
		Size:           query.GetSize(),
		HasMore:        utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
		VehicleDetails: record,
	}, nil
}

func (v *vehicleDetailsRepo) GetByVinID(ctx context.Context, vinID string) (*models.VehicleDetails, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleDetailsRepo.GetByVinID")
	defer span.Finish()

	var record models.VehicleDetails
	if result := v.db.Where("vin_id = ?", vinID).First(&record); result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return nil, nil // Return nil if the record is not found
		}
		return nil, errors.Wrap(result.Error, "vehicleDetailsRepo.GetByVinID")
	}

	return &record, nil
}

func (v *vehicleDetailsRepo) Create(ctx context.Context, vehicleDetails *models.VehicleDetails) (*models.VehicleDetails, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleDetailsRepo.Create")
	defer span.Finish()

	if result := v.db.Create(&vehicleDetails); result.Error != nil {
		return nil, errors.Wrap(result.Error, "vehicleDetailsRepo.Create")
	}

	return vehicleDetails, nil
}

func (v *vehicleDetailsRepo) Update(ctx context.Context, vehicleDetails *models.VehicleDetails) (*models.VehicleDetails, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleDetailsRepo.Update")
	defer span.Finish()

	if result := v.db.Where("vin_id = ?", vehicleDetails.VinID).Updates(&vehicleDetails); result.Error != nil {
		return nil, errors.Wrap(result.Error, "vehicleDetailsRepo.Update")
	}

	return vehicleDetails, nil
}

func (v *vehicleDetailsRepo) Delete(ctx context.Context, vinID string) error {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleDetailsRepo.Delete")
	defer span.Finish()

	if result := v.db.Where("vin_id = ?", vinID).Delete(&models.VehicleDetails{}); result.Error != nil {
		return errors.Wrap(result.Error, "vehicleDetailsRepo.Delete")
	}

	return nil
}

func NewVehicleDetailsRepository(db *gorm.DB) vehiclesdetails.Repository {
	return &vehicleDetailsRepo{db: db}
}
