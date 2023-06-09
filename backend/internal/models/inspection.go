package models

import "time"

// Inspection Inspection model
// swagger:model Inspection
type Inspection struct {
	InspectionID   int       `json:"inspection_id" db:"inspection_id"`
	RegistrationID string    `json:"registration_id" db:"registration_id"`
	InspectionDate time.Time `json:"inspection_date" db:"inspection_date"`
	ExpiryDate     time.Time `json:"expiry_date" db:"expiry_date"`
	StationCode    string    `json:"station_code" db:"station_code"`
}

func (Inspection) TableName() string {
	return "inspections"
}

// InspectionsList All Inspections response
type InspectionsList struct {
	TotalCount  int           `json:"total_count"`
	TotalPages  int           `json:"total_pages"`
	Page        int           `json:"page"`
	Size        int           `json:"size"`
	HasMore     bool          `json:"has_more"`
	Inspections []*Inspection `json:"inspections"`
}

type CarsCount struct {
	Q1 int `json:"q1"`
	Q2 int `json:"q2"`
	Q3 int `json:"q3"`
	Q4 int `json:"q4"`
}
type QuarterAndYear struct {
	Year      int       `json:"year"`
	CarsCount CarsCount `json:"cars_count"`
}

type CarsCountRegion struct {
	MB int `json:"mb"`
	MT int `json:"mt"`
	MN int `json:"mn"`
}
type RegionAndYear struct {
	Year            int             `json:"year"`
	CarsCountRegion CarsCountRegion `json:"cars_count_region"`
}

type StationQuarterAndYear struct {
	StationCode string    `json:"station_code"`
	Year        int       `json:"year"`
	CarsCount   CarsCount `json:"cars_count"`
}
