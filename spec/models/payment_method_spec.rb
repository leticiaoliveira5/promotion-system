 require 'rails_helper'

describe PaymentMethod do
   
   
    context 'PORO' do
        
        it 'should initialize a new payment method' do

            pm = PaymentMethod.new(name: 'Cartão de crédito', code: 'CCRED')

            expect(pm.name).to eq 'Cartão de crédito'
            expect(pm.code).to eq 'CCRED'

        end

    end
    
    context 'fetch API data' do

        it 'should get all payment methods' do
        
            GET 'pagamentos.com.br/api/v1/payment_methods'

            
        payment_methods = PaymentMethod.all
        
        expect(payment_methods.length).to eq 2
        
        end

    end

end

