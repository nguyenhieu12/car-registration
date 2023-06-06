package http

import (
	"backend/config"
	"backend/internal/auth"
	"backend/internal/models"
	"backend/pkg/logger"
	"backend/pkg/utils"
	"github.com/gofiber/fiber/v2"
	"github.com/google/uuid"
	"github.com/opentracing/opentracing-go"
)

type authHandlers struct {
	cfg         *config.Config
	authService auth.Service
	logger      logger.Logger
}

// Register godoc
// @Summary Register new user
// @Description register new user, returns user and token
// @Tags Auth
// @Accept json
// @Produce json
// @Success 201 {object} models.User
// @Router /auth/register [post]
func (a *authHandlers) Register() fiber.Handler {

	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "authHandlers.Register")
		defer span.Finish()

		user := &models.User{}

		if err := ctx.BodyParser(user); err != nil {
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": err.Error(),
			})
		}

		err := utils.ValidateStruct(customContext, user)
		if err != nil {
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": err.Error(),
			})
		}

		createdUser, err := a.authService.Register(customContext, user)
		if err != nil {
			a.logger.Error("authHandlers.Register ", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusCreated).JSON(&fiber.Map{
			"status": "success",
			"data":   &createdUser,
		})
	}
}

// Login godoc
// @Summary Login new user
// @Description login user, returns user and set session
// @Tags Auth
// @Accept json
// @Produce json
// @Success 200 {object} models.User
// @Router /auth/login [post]
func (a *authHandlers) Login() fiber.Handler {
	type Login struct {
		UserName string `json:"user_name" db:"user_name" validate:"required,omitempty,lte=60"`
		Password string `json:"password,omitempty" db:"password" validate:"required,gte=6"`
	}
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "authHandlers.Login")
		defer span.Finish()

		login := &Login{}
		if err := ctx.BodyParser(login); err != nil {
			a.logger.Error("authHandlers.Login.BodyParser ", err)
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": "err.Error",
			})
		}

		err := utils.ValidateStruct(customContext, login)
		if err != nil {
			a.logger.Error("authHandlers.Login.ValidateStruct ", err)
			return ctx.Status(fiber.StatusBadRequest).JSON(&fiber.Map{
				"status":  "Bad Request",
				"message": "err.Error",
			})
		}

		userWithToken, err := a.authService.Login(customContext, &models.User{
			UserName: login.UserName,
			Password: login.Password,
		})

		if err != nil {
			a.logger.Error("authHandlers.Login.userWithToken ", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": "err.Error",
			})
		}

		return ctx.Status(fiber.StatusCreated).JSON(&fiber.Map{
			"status": "success",
			"data":   &userWithToken,
		})
	}
}

// Logout godoc
// @Summary Logout user
// @Description logout user removing session
// @Tags Auth
// @Accept  json
// @Produce  json
// @Success 200 {string} string	"ok"
// @Router /auth/logout [post]
func (a *authHandlers) Logout() fiber.Handler {
	//TODO implement me
	panic("implement me")
}

// Update godoc
// @Summary Update user
// @Description update existing user
// @Tags Auth
// @Accept json
// @Param id path int true "user_id"
// @Produce json
// @Success 200 {object} models.User
// @Router /auth/{id} [put]
func (a *authHandlers) Update() fiber.Handler {
	//TODO implement me
	panic("implement me")
}

// Delete
// @Summary Delete user account
// @Description some description
// @Tags Auth
// @Accept json
// @Param id path int true "user_id"
// @Produce json
// @Success 200 {string} string	"ok"
// @Failure 500 {object} httpErrors.RestError
// @Router /auth/{id} [delete]
func (a *authHandlers) Delete() fiber.Handler {
	//TODO implement me
	panic("implement me")
}

// GetUserByID godoc
// @Summary get user by id
// @Description get string by ID
// @Tags Auth
// @Accept  json
// @Produce  json
// @Param id path int true "user_id"
// @Success 200 {object} models.User
// @Failure 500 {object} httpErrors.RestError
// @Router /auth/{id} [get]
func (a *authHandlers) GetUserByID() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "authHandlers.GetUserByID")
		defer span.Finish()

		uID, err := uuid.Parse(ctx.Params("user_id"))
		if err != nil {
			a.logger.Error("authHandlers.GetUserByID.Query", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})

		}

		user, err := a.authService.GetByID(customContext, uID)
		if err != nil {
			a.logger.Error("authHandlers.GetUserByID.GetByID", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   user,
		})
	}
}

// FindByName godoc
// @Summary Find by name
// @Description Find user by name
// @Tags Auth
// @Accept json
// @Param name query string false "username" Format(username)
// @Produce json
// @Success 200 {object} models.UsersList
// @Failure 500 {object} httpErrors.RestError
// @Router /auth/{name} [get]
func (a *authHandlers) FindByName() fiber.Handler {
	//TODO implement me
	panic("implement me")
}

// FindByUsername godoc
// @Summary Find by name
// @Description Find user by name
// @Tags Auth
// @Accept json
// @Param name query string false "username" Format(username)
// @Produce json
// @Success 200 {object} models.User
// @Failure 500 {object} httpErrors.RestError
// @Router /auth/{user_name} [get]
func (a *authHandlers) FindByUsername() fiber.Handler {
	//TODO implement me
	panic("implement me")
}

// FindByStationCode godoc
// @Summary Find by station code
// @Description Find user by station code
// @Tags Auth
// @Accept json
// @Produce json
// @Success 200 {object} models.UsersList
// @Failure 500 {object} httpErrors.RestError
// @Router /auth/{station_code} [get]
func (a *authHandlers) FindByStationCode() fiber.Handler {
	//TODO implement me
	panic("implement me")
}

// GetUsers godoc
// @Summary Get users
// @Description Get the list of all users
// @Tags Auth
// @Accept json
// @Param page query int false "page number" Format(page)
// @Param size query int false "number of elements per page" Format(size)
// @Param orderBy query int false "filter name" Format(orderBy)
// @Produce json
// @Success 200 {object} models.UsersList
// @Failure 500 {object} httpErrors.RestError
// @Router /auth/all [get]
func (a *authHandlers) GetUsers() fiber.Handler {
	return func(ctx *fiber.Ctx) error {
		span, customContext := opentracing.StartSpanFromContext(utils.GetRequestCtx(ctx), "authHandlers.GetUsers")
		defer span.Finish()

		paginationQuery, err := utils.GetPaginationFromCtx(ctx)
		if err != nil {
			a.logger.Error("authHandlers.GetUsers ", err)
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		users, err := a.authService.GetUsers(customContext, paginationQuery)
		if err != nil {
			return ctx.Status(fiber.StatusInternalServerError).JSON(&fiber.Map{
				"status":  "Internal Server Error",
				"message": err.Error(),
			})
		}

		return ctx.Status(fiber.StatusOK).JSON(&fiber.Map{
			"status": "success",
			"data":   users,
		})
	}

}

// GetMe godoc
// @Summary Get user by id
// @Description Get current user by id
// @Tags Auth
// @Accept json
// @Produce json
// @Success 200 {object} models.User
// @Failure 500 {object} httpErrors.RestError
// @Router /auth/me [get]
func (a *authHandlers) GetMe() fiber.Handler {
	//TODO implement me
	panic("implement me")
}

// GetCSRFToken godoc
// @Summary Get CSRF token
// @Description Get CSRF token, required auth session cookie
// @Tags Auth
// @Accept json
// @Produce json
// @Success 200 {string} string "Ok"
// @Failure 500 {object} httpErrors.RestError
// @Router /auth/token [get]
func (a *authHandlers) GetCSRFToken() fiber.Handler {
	//TODO implement me
	panic("implement me")
}

// NewAuthHandlers Auth handlers constructor
func NewAuthHandlers(cfg *config.Config, authService auth.Service, log logger.Logger) auth.Handlers {
	return &authHandlers{cfg: cfg, authService: authService, logger: log}
}
