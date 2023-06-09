package service

import (
	"backend/config"
	"backend/internal/models"
	"backend/internal/owner"
	"backend/pkg/logger"
	"context"
	"github.com/opentracing/opentracing-go"
)

type ownerService struct {
	cfg    *config.Config
	repo   owner.Repository
	logger logger.Logger
}

func (o *ownerService) GetByPersonIdentityNumber(ctx context.Context, personID string) (*models.Owner, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "ownerService.GetByPersonIdentityNumber")
	defer span.Finish()

	ownerRecord, err := o.repo.GetByPersonIdentityNumber(ctx, personID)
	if err != nil {
		return nil, err
	}

	return ownerRecord, nil
}

func (o *ownerService) GetByTaxIdentityNumber(ctx context.Context, taxID string) (*models.Owner, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "ownerService.GetByTaxIdentityNumber")
	defer span.Finish()

	ownerRecord, err := o.repo.GetByTaxIdentityNumber(ctx, taxID)
	if err != nil {
		return nil, err
	}

	return ownerRecord, nil
}

func (o *ownerService) Create(ctx context.Context, owner *models.Owner) (*models.Owner, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "ownerService.Create")
	defer span.Finish()

	createdOwner, err := o.repo.Create(ctx, owner)
	if err != nil {
		return nil, err
	}

	return createdOwner, nil
}

func (o *ownerService) Update(ctx context.Context, owner *models.Owner) (*models.Owner, error) {
	span, ctx := opentracing.StartSpanFromContext(ctx, "ownerService.Update")
	defer span.Finish()

	createdOwner, err := o.repo.Update(ctx, owner)
	if err != nil {
		return nil, err
	}

	return createdOwner, nil
}

func (o *ownerService) Delete(ctx context.Context, ownerID int) error {
	span, ctx := opentracing.StartSpanFromContext(ctx, "ownerService.Delete")
	defer span.Finish()

	err := o.repo.Delete(ctx, ownerID)
	return err
}

func NewOwnerService(cfg *config.Config, repo owner.Repository, log logger.Logger) owner.Service {
	return &ownerService{cfg: cfg, repo: repo, logger: log}
}
