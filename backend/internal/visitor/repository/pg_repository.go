package repository

import (
	"backend/internal/models"
	"backend/internal/visitor"
	"backend/pkg/utils"
	"context"
	"fmt"
	"github.com/opentracing/opentracing-go"
	"gorm.io/gorm"
)

type visitorRepo struct {
	db *gorm.DB
}

func (i *visitorRepo) GetByRegistrationID(ctx context.Context, registrationID string, query *utils.PaginationQuery) (*models.Visitor, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "visitorRepo.GetByRegistrationID")
	defer span.Finish()

	var results *models.PairResult
	err := i.db.Table("inspections i").
		Select("i.*, s.*").
		Joins("INNER JOIN station s ON i.station_code = s.station_code AND i.registration_id = ?", registrationID).
		Scan(&results).Error
	if err != nil {
		return nil, err
	}

	fmt.Println(results)

	var veh *models.Vehicle
	err = i.db.Table("vehicle v").
		Select("*").
		Joins("INNER JOIN inspections i ON i.registration_id = v.registration_id AND i.registration_id = ?", registrationID).
		First(&veh).Error
	if err != nil {
		return nil, err
	}

	return &models.Visitor{
		Vehicle: veh,
		Pair:    *results,
	}, nil
	//result := i.db.First(&models.Inspection{})
	//if result := i.db.First(&models.Inspection{}); result.Error != nil {
	//	return nil, errors.Wrap(result.Error, "visitorRepo.GetByRegistrationID.Results")
	//}

	//var totalCount int64
	//var inspections []*models.Inspection
	//
	//// Perform the join operation and select the required fields from both tables
	//queryBuilder := i.db.Model(&models.Inspection{}).
	//	Select("inspections.*, stations.*").
	//	Where("inspections.registration_id = ?", registrationID).
	//	Joins("JOIN stations ON inspections.registration_id = stations.registration_id")
	//
	//// Get the total count of inspections for the given registration ID
	//if result := queryBuilder.Count(&totalCount); result.Error != nil {
	//	return nil, errors.Wrap(result.Error, "inspectionRepo.GetByRegistrationID.Count")
	//}
	//
	//// Apply pagination and retrieve the inspections
	//if query != nil {
	//	queryBuilder = queryBuilder.Limit(query.GetSize()).Offset(query.GetOffset()).Order(query.GetOrderBy())
	//}
	//
	//if result := queryBuilder.Find(&inspections); result.Error != nil {
	//	return nil, errors.Wrap(result.Error, "inspectionRepo.GetByRegistrationID.Query")
	//}
	//
	//return &models.InspectionsList{
	//	TotalCount:  totalCount,
	//	Inspections: inspections,
	//}, nil
}

func NewVisitorRepository(db *gorm.DB) visitor.Repository {
	return &visitorRepo{db: db}
}
