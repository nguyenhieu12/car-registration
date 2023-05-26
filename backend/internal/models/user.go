package models

import (
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
	"strings"
	"time"
)

type User struct {
	UserID      uuid.UUID `json:"user_id" db:"user_id" gorm:"primaryKey;;type:uuid;default:uuid_generate_v4()" redis:"user_id" validate:"omitempty"`
	FirstName   string    `json:"first_name" db:"first_name" redis:"first_name" validate:"required,lte=30"`
	LastName    string    `json:"last_name" db:"last_name" redis:"last_name" validate:"required,lte=30"`
	Email       string    `json:"email,omitempty" db:"email" gorm:"not null" redis:"email" validate:"omitempty,lte=60,email"`
	UserName    string    `json:"user_name,omitempty" db:"user_name" gorm:"not null" redis:"user_name" validate:"omitempty,lte=60"`
	Password    string    `json:"password,omitempty" db:"password" gorm:"not null" redis:"password" validate:"omitempty,required,gte=6"`
	Role        *string   `json:"role,omitempty" db:"role" redis:"role" validate:"omitempty,lte=10"`
	About       *string   `json:"about,omitempty" db:"about" redis:"about" validate:"omitempty,lte=1024"`
	Avatar      *string   `json:"avatar,omitempty" db:"avatar" redis:"avatar" validate:"omitempty,lte=512,url"`
	PhoneNumber *string   `json:"phone_number,omitempty" db:"phone_number" redis:"phone_number" validate:"omitempty,lte=20"`
	StationCode string    `json:"station_code" db:"station_code" redis:"station_code" validate:"omitempty,lte=20"`
	IdentityNo  string    `json:"identity_no" db:"identity_no" redis:"identity_no" validate:"omitempty,lte=20"`
	CreatedAt   time.Time `json:"created_at,omitempty" db:"created_at" redis:"created_at"`
	UpdatedAt   time.Time `json:"updated_at,omitempty" db:"updated_at" redis:"updated_at"`
	LoginDate   time.Time `json:"login_date" db:"login_date" redis:"login_date"`
}

// HashPassword Hash user password with bcrypt
func (u *User) HashPassword() error {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(u.Password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}
	u.Password = string(hashedPassword)
	return nil
}

// ComparePasswords Compare user password and payload
func (u *User) ComparePasswords(password string) error {
	if err := bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(password)); err != nil {
		return err
	}
	return nil
}

// SanitizePassword Sanitize user password
func (u *User) SanitizePassword() {
	u.Password = ""
}

// PrepareCreate Prepare user for register
func (u *User) PrepareCreate() error {
	u.UserName = strings.ToLower(strings.TrimSpace(u.UserName))
	u.Password = strings.TrimSpace(u.Password)

	if err := u.HashPassword(); err != nil {
		return err
	}

	if u.PhoneNumber != nil {
		*u.PhoneNumber = strings.TrimSpace(*u.PhoneNumber)
	}
	if u.Role != nil {
		*u.Role = strings.ToLower(strings.TrimSpace(*u.Role))
	}
	return nil
}

// PrepareUpdate Prepare user for register
func (u *User) PrepareUpdate() error {
	u.UserName = strings.ToLower(strings.TrimSpace(u.UserName))

	if u.PhoneNumber != nil {
		*u.PhoneNumber = strings.TrimSpace(*u.PhoneNumber)
	}
	if u.Role != nil {
		*u.Role = strings.ToLower(strings.TrimSpace(*u.Role))
	}
	return nil
}

// UsersList All Users response
type UsersList struct {
	TotalCount int     `json:"total_count"`
	TotalPages int     `json:"total_pages"`
	Page       int     `json:"page"`
	Size       int     `json:"size"`
	HasMore    bool    `json:"has_more"`
	Users      []*User `json:"users"`
}

// UserWithToken Find user query
type UserWithToken struct {
	User  *User  `json:"user"`
	Token string `json:"token"`
}
