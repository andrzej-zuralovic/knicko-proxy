require 'rails_helper'

RSpec.describe CreateOrder do
  describe '#call' do
    context 'when the order_params are valid' do
      let(:valid_order_params) { { price_amount: 100, price_currency: 'USD', receive_currency: 'BTC', title: 'Test Order' } }

      it 'creates a new order with a generated order_id' do
        service = CreateOrder.new(valid_order_params)

        expect { service.call }.to change(Order, :count).by(1)

        order = service.call
        expect(order.order_id).not_to be_nil
      end
    end

    context 'when the order_params are invalid' do
      let(:invalid_order_params) { { price_amount: nil, price_currency: 'USD', receive_currency: 'BTC', title: 'Test Order' } }

      it 'raises a StandardError with error messages' do
        service = CreateOrder.new(invalid_order_params)

        expect { service.call }.to raise_error(StandardError, /can\'t be blank/)
      end
    end
  end
end
