require 'rails_helper'

RSpec.describe CreateCoingateOrder do
  let(:order) { create(:order) }
  let(:coingate_response) do
    {
      "id" => 91323,
      "status" => "new",
      "title" => "Awsome title",
      "do_not_convert" => false,
      "orderable_type" => "ApiApp",
      "orderable_id" => 1482,
      "uuid" => "1ce49c83-a464-4c69-9cef-deb071a0f722",
      "price_currency" => order.price_currency,
      "price_amount" => order.price_amount,
      "lightning_network" => false,
      "receive_currency" => order.receive_currency,
      "receive_amount" => "0",
      "created_at" => "2023-08-05T13:33:58+00:00",
      "order_id" => "d5661b96-76a9-4f95-aa6c-c3bf848a062f",
      "payment_url" => "https://pay-sandbox.coingate.com/invoice/1ce49c83-a464-4c69-9cef-deb071a0f722",
      "underpaid_amount" => "0",
      "overpaid_amount" => "0",
      "is_refundable" => false,
      "payment_request_uri" => nil,
      "refunds" => [],
      "voids" => [],
      "fees" => [],
      "token" => order.token,
    }
  end

  describe '#call' do
    it 'calls CoingateApi to create an order and updates the order status' do
      stub_request(:post, "#{Rails.configuration.coingate_api_url}/orders")
        .to_return(status: 200, body: coingate_response.to_json)

      expect { CreateCoingateOrder.new(order).call }.to change { order.status }.to('new')
    end

    it 'raises a StandardError with error messages if Coingate API response is not successful' do
      error_response = {
        'message' => 'Order is not valid',
        'reason' => 'OrderIsNotValid',
        'errors' => [
          "Price can't be blank",
        ],
      }
      stub_request(:post, "#{Rails.configuration.coingate_api_url}/orders")
        .to_return(status: 422, body: error_response.to_json)

      service = CreateCoingateOrder.new(order)

      expect { service.call }.to raise_error(StandardError, /Price can't be blank/)
      expect(order.reload.status).to be_nil
    end
  end
end
