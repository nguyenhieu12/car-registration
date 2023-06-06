package service

import (
	"backend/config"
	"backend/internal/auth"
	"backend/internal/models"
	"backend/pkg/httpErrors"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"context"
	"github.com/google/uuid"
	"github.com/opentracing/opentracing-go"
	"github.com/pkg/errors"
	"net/http"
)

type authService struct {
	cfg      *config.Config
	authRepo auth.Repository
	logger   logger.Logger
}

func (a *authService) Register(ctx context.Context, user *models.User) (*models.UserWithToken, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "authService.Register")
	defer span.Finish()

	existsUser, err := a.authRepo.FindByEmail(ctx, user)
	if existsUser != nil || err == nil {
		return nil, httpErrors.NewRestErrorWithMessage(http.StatusBadRequest, httpErrors.ErrEmailAlreadyExists, nil)
	}

	existsUser2, err := a.authRepo.GetByUsername(ctx, user.UserName)
	if existsUser2 != nil || err == nil {
		return nil, httpErrors.NewRestErrorWithMessage(http.StatusBadRequest, httpErrors.ErrUsernameAlreadyExists, nil)
	}

	if err = user.PrepareCreate(); err != nil {
		return nil, httpErrors.NewBadRequestError(errors.Wrap(err, "authService.Register.PrepareCreate"))
	}

	createdUser, err := a.authRepo.Register(ctx, user)
	if err != nil {
		return nil, err
	}
	createdUser.SanitizePassword()

	token, err := utils.GenerateJWTToken(createdUser, a.cfg)
	if err != nil {
		return nil, httpErrors.NewInternalServerError(errors.Wrap(err, "authService.Register.GenerateJWTToken"))
	}

	return &models.UserWithToken{
		User:  createdUser,
		Token: token,
	}, nil
}

func (a *authService) Login(ctx context.Context, user *models.User) (*models.UserWithToken, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "authService.Login")
	defer span.Finish()

	foundUser, err := a.authRepo.GetByUsername(ctx, user.UserName)
	if err != nil {
		return nil, err
	}

	if err = foundUser.ComparePasswords(user.Password); err != nil {
		return nil, httpErrors.NewUnauthorizedError(errors.Wrap(err, "authService.Login.ComparePasswords"))
	}

	foundUser.SanitizePassword()

	token, err := utils.GenerateJWTToken(foundUser, a.cfg)
	if err != nil {
		return nil, httpErrors.NewInternalServerError(errors.Wrap(err, "authService.Login.GenerateJWTToken"))
	}

	return &models.UserWithToken{
		User:  foundUser,
		Token: token,
	}, nil
}

func (a *authService) Update(ctx context.Context, user *models.User) (*models.User, error) {
	//TODO implement me
	panic("implement me 1")
}

func (a *authService) Delete(ctx context.Context, userID uuid.UUID) error {
	//TODO implement me
	panic("implement me 2")
}

func (a *authService) GetByID(ctx context.Context, userID uuid.UUID) (*models.User, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "authUC.GetByID")
	defer span.Finish()

	//cachedUser, err := u.redisRepo.GetByIDCtx(ctx, u.GenerateUserKey(userID.String()))
	//if err != nil {
	//	u.logger.Errorf("authUC.GetByID.GetByIDCtx: %v", err)
	//}
	//if cachedUser != nil {
	//	return cachedUser, nil
	//}

	user, err := a.authRepo.GetByID(ctx, userID)
	if err != nil {
		return nil, err
	}

	//if err = a.redisRepo.SetUserCtx(ctx, u.GenerateUserKey(userID.String()), cacheDuration, user); err != nil {
	//	a.logger.Errorf("authUC.GetByID.SetUserCtx: %v", err)
	//}

	user.SanitizePassword()

	return user, nil
}

func (a *authService) FindByUsername(ctx context.Context, name string, query *utils.PaginationQuery) (*models.User, error) {
	//TODO implement me
	panic("implement me 4")
}

func (a *authService) FindByStationCode(ctx context.Context, stationCode string) (*models.UsersList, error) {
	//TODO implement me
	panic("implement me 5")
}

func (a *authService) FindByEmail(ctx context.Context, user *models.User) (*models.User, error) {
	//TODO implement me
	panic("implement me 6")
}

func (a *authService) GetUsers(ctx context.Context, pq *utils.PaginationQuery) (*models.UsersList, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "authService.GetUsers")
	defer span.Finish()

	return a.authRepo.GetUsers(ctx, pq)
}

// NewAuthService Auth Service constructor
func NewAuthService(cfg *config.Config, authRepo auth.Repository, log logger.Logger) auth.Service {
	return &authService{cfg: cfg, authRepo: authRepo, logger: log}
}
