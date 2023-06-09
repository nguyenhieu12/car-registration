package repository

import (
	"backend/internal/models"
	"backend/internal/owner"
	"context"
	"github.com/opentracing/opentracing-go"
	"github.com/pkg/errors"
	"gorm.io/gorm"
)

type ownerRepo struct {
	db *gorm.DB
}

func (o *ownerRepo) GetByPersonIdentityNumber(ctx context.Context, personID string) (*models.Owner, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "ownerRepo.GetByPersonIdentityNumber")
	defer span.Finish()

	var owner models.Owner
	if result := o.db.Where("person_identity_number = ?", personID).First(&owner); result.Error != nil {
		return nil, errors.Wrap(result.Error, "ownerRepo.GetByPersonIdentityNumber")
	}

	return &owner, nil
}

func (o *ownerRepo) GetByTaxIdentityNumber(ctx context.Context, taxID string) (*models.Owner, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "ownerRepo.GetByTaxIdentityNumber")
	defer span.Finish()

	var owner models.Owner
	if result := o.db.Where("tax_identity_number = ?", taxID).First(&owner); result.Error != nil {
		return nil, errors.Wrap(result.Error, "ownerRepo.GetByTaxIdentityNumber")
	}

	return &owner, nil
}

func (o *ownerRepo) Create(ctx context.Context, owner *models.Owner) (*models.Owner, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "ownerRepo.Create")
	defer span.Finish()

	if result := o.db.Create(&owner); result.Error != nil {
		return nil, errors.Wrap(result.Error, "ownerRepo.Create")
	}

	return owner, nil
}

func (o *ownerRepo) Update(ctx context.Context, owner *models.Owner) (*models.Owner, error) {
	span, _ := opentracing.StartSpanFromContext(ctx, "ownerRepo.Update")
	defer span.Finish()

	if result := o.db.Where("owner_id = ?", owner.OwnerID).Updates(&owner); result.Error != nil {
		return nil, errors.Wrap(result.Error, "ownerRepo.Update")
	}

	return owner, nil
}

func (o *ownerRepo) Delete(ctx context.Context, ownerID int) error {
	span, _ := opentracing.StartSpanFromContext(ctx, "ownerRepo.Delete")
	defer span.Finish()

	if result := o.db.Where("owner_id = ?", ownerID).Delete(&models.Owner{}); result.Error != nil {
		return errors.Wrap(result.Error, "ownerRepo.Delete")
	}

	return nil
}

func NewOwnerRepository(db *gorm.DB) owner.Repository {
	return &ownerRepo{db: db}
}
