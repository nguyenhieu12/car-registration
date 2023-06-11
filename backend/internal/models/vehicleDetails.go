package models

type VehicleDetails struct {
	VinID                            string  `json:"vin_id" db:"vin_id" gorm:"primaryKey" validate:"required"`
	Mark                             *string `json:"mark,omitempty" db:"mark"`
	ManufacturedYear                 *int    `json:"manufactured_year,omitempty" db:"manufactured_year"`
	ModelCode                        *string `json:"model_code,omitempty" db:"model_code"`
	Type                             *string `json:"type,omitempty" db:"type"`
	CommercialUse                    *string `json:"commercial_use,omitempty" db:"commercial_use"`
	Modification                     *string `json:"modification,omitempty" db:"modification"`
	WheelFormula                     *string `json:"wheel_formula,omitempty" db:"wheel_formula"`
	WheelTread                       *string `json:"wheel_tread,omitempty" db:"wheel_tread"`
	OverallDimension                 *string `json:"overall_dimension,omitempty" db:"overall_dimension"`
	LargestLuggageContainerDimension *string `json:"largest_luggage_container_dimension,omitempty" db:"largest_luggage_container_dimension"`
	WheelBase                        *string `json:"wheel_base,omitempty" db:"wheel_base"`
	KerbMass                         *string `json:"kerb_mass,omitempty" db:"kerb_mass"`
	DesignAuthorizedPayLoad          *string `json:"design_authorized_pay_load,omitempty" db:"design__authorized_pay_load"`
	DesignAuthorizedTowedMass        *string `json:"design_authorized_towed_mass,omitempty" db:"design__authorized_towed_mass"`
	DesignAuthorizedTotalMass        *string `json:"design_authorized_total_mass,omitempty" db:"design__authorized_total_mass"`
	PermissibleNoOfPerCarried        *int    `json:"permissible_no_of_per_carried,omitempty" db:"permissible_no_of_per_carried"`
	Seat                             *int    `json:"seat,omitempty" db:"seat"`
	StoodPlace                       *int    `json:"stood_place,omitempty" db:"stood_place"`
	LayingPlace                      *int    `json:"laying_place,omitempty" db:"laying_place"`
	TypeOfFuelUsed                   *string `json:"type_of_fuel_used,omitempty" db:"type_of_fuel_used"`
	MaxOutput                        *string `json:"max_output,omitempty" db:"max_output"`
	RPM                              *int    `json:"rpm,omitempty" db:"rpm"`
	EngineDisplacement               *string `json:"engine_displacement,omitempty" db:"engine_displacement"`
	NumberOfTires                    *int    `json:"number_of_tires,omitempty" db:"number_of_tires"`
	TiresSizeAxle                    *string `json:"tires_size_axle,omitempty" db:"tires_size__axle"`
	EquippedWithTachograph           *bool   `json:"equipped_with_tachograph,omitempty" db:"equipped_with_tachograph"`
	EquippedWithCamera               *bool   `json:"equipped_with_camera,omitempty" db:"equipped_with_camera"`
	Notes                            *string `json:"notes,omitempty" db:"notes"`
}

func (VehicleDetails) TableName() string {
	return "vehicledetails"
}

type VehicleDetailsList struct {
	TotalCount     int               `json:"total_count"`
	TotalPages     int               `json:"total_pages"`
	Page           int               `json:"page"`
	Size           int               `json:"size"`
	HasMore        bool              `json:"has_more"`
	VehicleDetails []*VehicleDetails `json:"vehicle_details_list"`
}
