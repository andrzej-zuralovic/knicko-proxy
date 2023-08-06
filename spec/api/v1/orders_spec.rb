require 'rails_helper'

RSpec.describe Api::V1::Orders do
  let(:headers) { { "Authorization" => "Bearer test" } }

  describe 'POST /api/v1/orders' do
    let(:api_response) do
      {
        "id" => 91323,
        "status" => "new",
        "title" => "Awsome title",
        "do_not_convert" => false,
        "orderable_type" => "ApiApp",
        "orderable_id" => 1482,
        "uuid" => "1ce49c83-a464-4c69-9cef-deb071a0f722",
        "price_currency" => "EUR",
        "price_amount" => "1",
        "lightning_network" => false,
        "receive_currency" => "EUR",
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
        "token" => "deb071a0f722",
      }
    end

    before do
      stub_request(:post, "#{Rails.configuration.coingate_api_url}/orders").to_return(body: api_response.to_json)
    end

    context 'when params are valid' do
      let(:params) do
        {
          price_amount: 10,
          receive_currency: 'EUR',
          price_currency: 'EUR',
        }
      end

      it 'creates order' do
        expect {
          post "/api/v1/orders", params:, headers:
        }.to change(Order, :count).by(1)

        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)).to include('coingate_response' => api_response)
      end
    end

    context 'when params are invalid' do
      let(:params) do
        {
          receive_currency: 'EUR',
          price_currency: 'EUR',
        }
      end

      it 'does not create order' do
        expect { post "/api/v1/orders", params:, headers: }.not_to change(Order, :count)
        expect(response).to have_http_status(400)
        expect(response.body).to eq({ error: 'price_amount is missing' }.to_json)
      end
    end
  end

  describe 'GET /api/v1/orders/:id' do
    context 'when order is found' do
      let(:order) { create(:order, coingate_response: { status: 'new' }) }

      it 'returns order' do
        get("/api/v1/orders/#{order.id}", headers:)
        expect(response).to have_http_status(200)
        expect(response.body).to eq(order.to_json)
      end
    end

    context 'when order is not found' do
      it 'returns a not found error' do
        order_id = 9999

        get("/api/v1/orders/#{order_id}", headers:)
        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ error: 'The requested order was not found.' }.to_json)
      end
    end
  end
end
