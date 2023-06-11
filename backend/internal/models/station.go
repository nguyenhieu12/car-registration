package models

type Station struct {
	StationID        int64   `json:"station_id" db:"station_id" gorm:"primaryKey;autoIncrement"`
	StationCode      *string `json:"station_code,omitempty" db:"station_code"`
	StationName      string  `json:"station_name" db:"station_name" validate:"required"`
	Province         string  `json:"province" db:"province" validate:"required"`
	StationURL       *string `json:"station_url,omitempty" db:"station_url"`
	StationHotline   *string `json:"station_hotline,omitempty" db:"station_hotline"`
	StationAddress   *string `json:"station_address,omitempty" db:"station_address"`
	StationEmail     *string `json:"station_email,omitempty" db:"station_email"`
	StationMapSource *string `json:"station_map_source,omitempty" db:"station_map_source"`
	StationManager   string  `json:"station_manager" db:"station_manager" validate:"required"`
	StationStatus    bool    `json:"station_status" db:"station_status"`
}

func (Station) TableName() string {
	return "stations"
}
