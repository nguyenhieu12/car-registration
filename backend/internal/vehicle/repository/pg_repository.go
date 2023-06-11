package repository

import (
	"backend/internal/models"
	"backend/internal/vehicle"
	"backend/pkg/utils"
	"context"
	"github.com/opentracing/opentracing-go"
	"github.com/pkg/errors"
	"gorm.io/gorm"
)

type vehicleRepo struct {
	db *gorm.DB
}

func (v *vehicleRepo) GetDetailsByRegistrationID(ctx context.Context, registrationID string) (*models.VehiclesAndDetails, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleRepo.GetDetailsByRegistrationID")
	defer span.Finish()
	return nil, nil

	//var results models.VehiclesAndDetails
	//err := v.db.Table("vehicle v").
	//	Select(`
	//		v.registration_id,
	//		v.inspection_id,
	//		v.registration_date,
	//		v.place_of_registration,
	//		v.chassis_number,
	//		v.engine_number,
	//		v.vin_id,
	//		v.manufactured_country,
	//		v.manufactured_year,
	//		v.brand,
	//		v.model_code,
	//		v.color,
	//		v.owner_id,
	//		vd.commercial_use,
	//		vd.modification,
	//		vd.wheel_formula,
	//		vd.wheel_tread,
	//		vd.overall_dimension,
	//		vd.largest_luggage_container_dimension,
	//		vd.wheel_base,
	//		vd.kerb_mass,
	//		vd.design__authorized_pay_load,
	//		vd.design__authorized_towed_mass,
	//		vd.design__authorized_total_mass,
	//		vd.permissible_no_of_per_carried,
	//		vd.seat,
	//		vd.stood_place,
	//		vd.laying_place,
	//		vd.type_of_fuel_used,
	//		vd.max_output,
	//		vd.rpm,
	//		vd.engine_displacement,
	//		vd.number_of_tires,
	//		vd.tires_size__axle,
	//		vd.equipped_with_tachograph,
	//		vd.equipped_with_camera,
	//		vd.notes`).
	//	Joins("INNER JOIN vehicledetails vd ON v.vin_id = vd.vin_id  AND v.registration_id = ?", registrationID).
	//	Scan(&results).Error
	//if err != nil {
	//	log.Fatal(err)
	//}
	//
	//return &results, nil

}

func (v *vehicleRepo) GetAll(ctx context.Context, query *utils.PaginationQuery) (*models.VehiclesList, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleRepo.GetAll")
	defer span.Finish()

	result := v.db.First(&models.Vehicle{})

	totalCount := int(result.RowsAffected)
	if result := v.db.First(&models.Vehicle{}); result.Error != nil {
		return nil, errors.Wrap(result.Error, "vehicleRepo.GetAll.Results")
	}

	if totalCount == 0 {
		return &models.VehiclesList{
			TotalCount: totalCount,
			TotalPages: utils.GetTotalPages(totalCount, query.GetSize()),
			Page:       query.GetPage(),
			Size:       query.GetSize(),
			HasMore:    utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
			Vehicles:   make([]*models.Vehicle, 0),
		}, nil
	}

	var vehicles = make([]*models.Vehicle, 0, query.GetSize())
	if records := v.db.Limit(query.GetLimit()).Offset(query.GetOffset()).Order(query.GetOrderBy()).Find(&vehicles); records.Error != nil {
		return nil, errors.Wrap(records.Error, "vehicleRepo.GetAll.Query")
	}

	return &models.VehiclesList{
		TotalCount: totalCount,
		TotalPages: utils.GetTotalPages(totalCount, query.GetSize()),
		Page:       query.GetPage(),
		Size:       query.GetSize(),
		HasMore:    utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
		Vehicles:   vehicles,
	}, nil
}

func (v *vehicleRepo) GetByRegistrationID(ctx context.Context, registrationID string) (*models.Vehicle, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleRepo.GetByRegistrationID")
	defer span.Finish()

	var record models.Vehicle
	if result := v.db.Where("registration_id = ?", registrationID).First(&record); result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return nil, nil // Return nil if the record is not found
		}
		return nil, errors.Wrap(result.Error, "vehicleRepo.GetByRegistrationID")
	}

	return &record, nil
}

func (v *vehicleRepo) Create(ctx context.Context, vehicle *models.Vehicle) (*models.Vehicle, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleRepo.Create")
	defer span.Finish()

	if result := v.db.Create(&vehicle); result.Error != nil {
		return nil, errors.Wrap(result.Error, "vehicleRepo.Create")
	}

	return vehicle, nil
}

func (v *vehicleRepo) Update(ctx context.Context, vehicle *models.Vehicle) (*models.Vehicle, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleRepo.Update")
	defer span.Finish()

	if result := v.db.Where("registration_id = ?", vehicle.RegistrationID).Updates(&vehicle); result.Error != nil {
		return nil, errors.Wrap(result.Error, "vehicleRepo.Update")
	}

	return vehicle, nil
}

func (v *vehicleRepo) Delete(ctx context.Context, registrationID string) error {
	span, _ := opentracing.StartSpanFromContext(ctx, "vehicleRepo.Delete")
	defer span.Finish()

	if result := v.db.Where("registration_id = ?", registrationID).Delete(&models.Vehicle{}); result.Error != nil {
		return errors.Wrap(result.Error, "vehicleRepo.Delete")
	}

	return nil
}

func NewVehicleRepository(db *gorm.DB) vehicle.Repository {
	return &vehicleRepo{db: db}
}
