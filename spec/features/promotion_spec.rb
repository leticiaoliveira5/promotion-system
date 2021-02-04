require 'rails_helper'

describe Promotion do
  context 'validation' do
    it 'attributes cannot be blank' do
      promotion = Promotion.new

      promotion.valid?

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em '\
                                                          'branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em'\
                                                            ' branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em'\
                                                            ' branco')
    end

    it 'code must be uniq' do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033')
      promotion = Promotion.new(code: 'NATAL10')

      promotion.valid?

      expect(promotion.errors[:code]).to include('deve ser único')
    end
  end

  context '#generate_coupons!' do
    it 'generate coupons of coupon_quantity' do
      promotion = Promotion.create!(name: 'Dia dos Pais', 
                  description: 'Promoção de Dia dos Pais',
                  code: 'PAIS25', discount_rate: 25,
                  coupon_quantity: 50, expiration_date: '22/07/2021')
      promotion.generate_coupons!

      expect(promotion.coupons.size).to eq(50)
      codes = promotion.coupons.pluck(:code)
      expect(codes).to include("PAIS25-0001")
      expect(codes).to include("PAIS25-0010")
      expect(codes).to include("PAIS25-0050")
      expect(codes).not_to include("PAIS25-0051")
    
    end
  end

  it 'do not generate if error' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033')
    promotion.coupons.create!(code: 'NATAL10-0030')

    expect { promotion.generate_coupons! }.to raise_error(ActiveRecord::RecordNotUnique)

    expect(promotion.coupons.reload.size).to eq(1)
  end

end
