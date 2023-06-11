package models

import (
	"github.com/google/uuid"
	"time"
)

type Vehicle struct {
	RegistrationID      string    `json:"registration_id" db:"registration_id" validate:"required,lte=255"`
	InspectionID        string    `json:"inspection_id" db:"inspection_id" validate:"required,lte=255"`
	RegistrationDate    time.Time `json:"registration_date" db:"registration_date"`
	PlaceOfRegistration string    `json:"place_of_registration" db:"place_of_registration" validate:"required,lte=255"`
	ChassisNumber       string    `json:"chassis_number" db:"chassis_number" validate:"required,lte=255"`
	EngineNumber        string    `json:"engine_number" db:"engine_number" validate:"required,lte=255"`
	VinID               string    `json:"vin_id" db:"vin_id" validate:"required,lte=255"`
	ManufacturedCountry string    `json:"manufactured_country" db:"manufactured_country" validate:"required,lte=255"`
	ManufacturedYear    int       `json:"manufactured_year" db:"manufactured_year" validate:"required"`
	Brand               string    `json:"brand" db:"brand" validate:"required,lte=255"`
	ModelCode           string    `json:"model_code" db:"model_code" validate:"required,lte=255"`
	Color               string    `json:"color" db:"color" validate:"required,lte=255"`
	OwnerID             uuid.UUID `json:"owner_id" db:"owner_id" gorm:"type:uuid" validate:"required"`
}

func (Vehicle) TableName() string {
	return "vehicle"
}

type VehiclesAndDetails struct {
	*Vehicle        `json:"vehicle"`
	*VehicleDetails `json:"vehicle_details"`
}

type VehiclesList struct {
	TotalCount int        `json:"total_count"`
	TotalPages int        `json:"total_pages"`
	Page       int        `json:"page"`
	Size       int        `json:"size"`
	HasMore    bool       `json:"has_more"`
	Vehicles   []*Vehicle `json:"vehicles"`
}
