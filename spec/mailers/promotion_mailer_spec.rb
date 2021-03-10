require 'rails_helper'

describe PromotionMailer do
    describe '#notfy_apporval' do
        it 'should build and email correctly' do
        
            user = create(:user, email: 'user@email.com')
            another_user = create(:user, email:'another@mail.com')
            promotion = create(:promotion, name:'BlackFraude', user:user)
            PromotionApproval.create(promotion: promotion, user: another_user)
            mail = PromotionMailer.notify_approval(promotion.id)

            expect(mail.subject).to eq 'A promoção BlackFraude foi aprovada'
            expect(mail.to).to include 'user@email.com'
            #expect(mail.to).to eq [user@email.com]
            expect(mail.body).to include 'Sua promoção BlackFraude foi aprovada'
        end
    end
end