package repository

import (
	"backend/internal/auth"
	"backend/internal/models"
	"backend/pkg/utils"
	"context"
	"github.com/google/uuid"
	"github.com/opentracing/opentracing-go"
	"github.com/pkg/errors"
	"gorm.io/gorm"
)

type authRepo struct {
	db *gorm.DB
}

func (a *authRepo) Register(ctx context.Context, user *models.User) (*models.User, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "authRepo.Register")
	defer span.Finish()

	if result := a.db.Create(&user); result.Error != nil {
		return nil, errors.Wrap(result.Error, "authRepo.Register.Create")
	}

	return user, nil
}

func (a *authRepo) Update(ctx context.Context, user *models.User) (*models.User, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "authRepo.Update")
	defer span.Finish()

	if result := a.db.Where("user_id = ?", user.UserID).Updates(&user); result.Error != nil {
		return nil, errors.Wrap(result.Error, "authRepo.Update.Where.Update")
	}
	return user, nil
}

func (a *authRepo) Delete(ctx context.Context, userID uuid.UUID) error {
	span, _ := opentracing.StartSpanFromContext(ctx, "authRepo.Delete")
	defer span.Finish()
	if result := a.db.Where("user_id = ?", userID).Delete(&models.User{}); result.Error != nil {
		return errors.Wrap(result.Error, "authRepo.Delete.Where.Delete")
	}
	return nil
}

func (a *authRepo) GetByID(ctx context.Context, userID uuid.UUID) (*models.User, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "authRepo.GetByID")
	defer span.Finish()
	var user models.User
	if result := a.db.Where("user_id = ?", userID).First(&user); result.Error != nil {
		return nil, errors.Wrap(result.Error, "authRepo.GetByID.Where.First")
	}
	return &user, nil
}

func (a *authRepo) GetByUsername(ctx context.Context, username string) (*models.User, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "authRepo.GetByUsername")
	defer span.Finish()
	var foundUser models.User
	if result := a.db.Where("user_name = ?", username).First(&foundUser); result.Error != nil {
		return nil, errors.Wrap(result.Error, "authRepo.GetByUsername.Where.First")
	}
	return &foundUser, nil
}

func (a *authRepo) FindByStationCode(ctx context.Context, stationCode string, query *utils.PaginationQuery) (*models.UsersList, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "authRepo.FindByStationCode")
	defer span.Finish()

	result := a.db.First(&models.User{})

	totalCount := int(result.RowsAffected)
	if result := a.db.First(&models.User{}); result.Error != nil {
		return nil, errors.Wrap(result.Error, "authRepo.FindByStationCode.Results")
	}

	if totalCount == 0 {
		return &models.UsersList{
			TotalCount: totalCount,
			TotalPages: utils.GetTotalPages(totalCount, query.GetSize()),
			Page:       query.GetPage(),
			Size:       query.GetSize(),
			HasMore:    utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
			Users:      make([]*models.User, 0),
		}, nil
	}

	var users = make([]*models.User, 0, query.GetSize())
	if records := a.db.Where("station_code = ?", stationCode).Limit(query.GetLimit()).Offset(query.GetOffset()).Order(query.GetOrderBy()).Find(&users); records.Error != nil {
		return nil, errors.Wrap(records.Error, "authRepo.GetUsers.Query")
	}
	for _, u := range users {
		u.SanitizePassword()
	}

	return &models.UsersList{
		TotalCount: totalCount,
		TotalPages: utils.GetTotalPages(totalCount, query.GetSize()),
		Page:       query.GetPage(),
		Size:       query.GetSize(),
		HasMore:    utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
		Users:      users,
	}, nil
}

func (a *authRepo) FindByEmail(ctx context.Context, user *models.User) (*models.User, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "authRepo.FindByEmail")
	defer span.Finish()
	var foundUser models.User
	if result := a.db.Where("email = ?", user.Email).First(&foundUser); result.Error != nil {
		return nil, errors.Wrap(result.Error, "authRepo.FindByEmail.Where.First")
	}
	return &foundUser, nil
}

func (a *authRepo) GetUsers(ctx context.Context, query *utils.PaginationQuery) (*models.UsersList, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "authRepo.GetUsers")
	defer span.Finish()

	result := a.db.First(&models.User{})

	totalCount := int(result.RowsAffected)
	if result := a.db.First(&models.User{}); result.Error != nil {
		return nil, errors.Wrap(result.Error, "authRepo.GetUsers.Results")
	}

	if totalCount == 0 {
		return &models.UsersList{
			TotalCount: totalCount,
			TotalPages: utils.GetTotalPages(totalCount, query.GetSize()),
			Page:       query.GetPage(),
			Size:       query.GetSize(),
			HasMore:    utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
			Users:      make([]*models.User, 0),
		}, nil
	}

	var users = make([]*models.User, 0, query.GetSize())
	if records := a.db.Limit(query.GetLimit()).Offset(query.GetOffset()).Order(query.GetOrderBy()).Find(&users); records.Error != nil {
		return nil, errors.Wrap(records.Error, "authRepo.GetUsers.Query")
	}
	for _, u := range users {
		u.SanitizePassword()
	}

	return &models.UsersList{
		TotalCount: totalCount,
		TotalPages: utils.GetTotalPages(totalCount, query.GetSize()),
		Page:       query.GetPage(),
		Size:       query.GetSize(),
		HasMore:    utils.GetHasMore(query.GetPage(), totalCount, query.GetSize()),
		Users:      users,
	}, nil
}

// NewAuthRepository Auth Repository constructor
func NewAuthRepository(db *gorm.DB) auth.Repository {
	return &authRepo{db: db}
}
