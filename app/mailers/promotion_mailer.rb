class PromotionMailer < ApplicationMailer

    def notify_approval(promotion_id)
        @promotion = Promotion.find(promotion_id)
        mail(subject: "A promoção #{@promotion.name} foi aprovada",
        to: @promotion.user.email)
    end

end