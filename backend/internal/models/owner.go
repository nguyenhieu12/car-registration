package models

type Owner struct {
	OwnerID              int    `json:"owner_id" db:"owner_id"`
	OwnerType            string `json:"owner_type" db:"owner_type"`
	FullName             string `json:"full_name" db:"full_name"`
	Address              string `json:"address" db:"address"`
	PersonIdentityNumber string `json:"person_identity_number" db:"person_identity_number"`
	TaxIdentityNumber    string `json:"tax_identity_number" db:"tax_identity_number"`
}

func (Owner) TableName() string {
	return "owner"
}

type OwnersList struct {
	TotalCount int      `json:"total_count"`
	TotalPages int      `json:"total_pages"`
	Page       int      `json:"page"`
	Size       int      `json:"size"`
	HasMore    bool     `json:"has_more"`
	Owners     []*Owner `json:"owners"`
}
