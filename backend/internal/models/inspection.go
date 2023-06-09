package models

import "time"

type Inspection struct {
	InspectionID   int       `json:"inspection_id" db:"inspection_id"`
	RegistrationID string    `json:"registration_id" db:"registration_id"`
	InspectionDate time.Time `json:"inspection_date" db:"inspection_date"`
	ExpiryDate     time.Time `json:"expiry_date" db:"expiry_date"`
	StationCode    string    `json:"station_code" db:"station_code"`
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
