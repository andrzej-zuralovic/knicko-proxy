require 'rails_helper'

RSpec.describe Api::V1::PaymentCallback do
  describe 'POST /v1/payment_callback' do
    let(:order_id) { SecureRandom.uuid }
    let(:token) { 'TOKEN' }
    let(:status) { 'success' }
    let(:coingate_response) { { 'order_id' => order_id, 'token' => token, 'status' => status } }
    let!(:order) { create(:order, order_id:, token:, status: 'new') }

    context 'when receiving a callback' do
      before do
        post '/api/v1/payment_callback', params: coingate_response
      end

      it 'updates the order status correctly' do
        expect { order.reload.status }.to change { order.status }.from('new').to(status)
      end

      it 'updates the coingate_response' do
        expect(order.reload.coingate_response).to eq(coingate_response)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
