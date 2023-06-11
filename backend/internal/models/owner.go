package models

import "github.com/google/uuid"

type Owner struct {
	OwnerID              uuid.UUID `json:"owner_id" db:"owner_id" gorm:"primaryKey;type:uuid;default:uuid_generate_v4()" validate:"omitempty"`
	OwnerType            string    `json:"owner_type" db:"owner_type" validate:"required,lte=255"`
	FullName             string    `json:"full_name" db:"full_name" validate:"required,lte=255"`
	Address              string    `json:"address" db:"address" validate:"required,lte=255"`
	PersonIdentityNumber string    `json:"person_identity_number" db:"person_identity_number" validate:"omitempty,lte=255"`
	TaxIdentityNumber    string    `json:"tax_identity_number" db:"tax_identity_number" validate:"omitempty,lte=255"`
}

func (Owner) TableName() string {
	return "owners"
}

type OwnersList struct {
	TotalCount int      `json:"total_count"`
	TotalPages int      `json:"total_pages"`
	Page       int      `json:"page"`
	Size       int      `json:"size"`
	HasMore    bool     `json:"has_more"`
	Owners     []*Owner `json:"owners"`
}
