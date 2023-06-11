package models

type Area struct {
	Province string `json:"province" db:"province" validate:"required"`
	Area     string `json:"area" db:"area" validate:"required"`
}

func (Area) TableName() string {
	return "area"
}
