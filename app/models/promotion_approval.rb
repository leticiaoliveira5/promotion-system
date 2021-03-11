class PromotionApproval < ApplicationRecord
  belongs_to :user
  belongs_to :promotion

  validate :different_user

  private

  def different_user
    errors.add(:user, 'não pode ser o criador da promoção') if promotion && promotion.user == user # curto circuito
  end
end
