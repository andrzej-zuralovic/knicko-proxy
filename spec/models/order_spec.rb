require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) do
    build(:order,
    order_id: SecureRandom.uuid,
    price_amount: 100,
    price_currency: 'USD',
    receive_currency: 'BTC',
    title: 'Test Order',
    description: 'This is a test order')
  end

  describe 'validations' do
    it 'validates uniqueness of order_id' do
      create(:order, order_id: order.order_id)
      expect(order).not_to be_valid
      expect(order.errors[:order_id]).to include('has already been taken')
    end

    it 'validates presence of price_amount' do
      order.price_amount = nil
      expect(order).not_to be_valid
      expect(order.errors[:price_amount]).to include("can't be blank")
    end

    it 'validates presence of price_currency' do
      order.price_currency = nil
      expect(order).not_to be_valid
      expect(order.errors[:price_currency]).to include("can't be blank")
    end

    it 'validates presence of receive_currency' do
      order.receive_currency = nil
      expect(order).not_to be_valid
      expect(order.errors[:receive_currency]).to include("can't be blank")
    end

    it 'validates length of title' do
      order.title = 'a' * 151
      expect(order).not_to be_valid
      expect(order.errors[:title]).to include('is too long (maximum is 150 characters)')
    end

    it 'validates length of description' do
      order.description = 'a' * 501
      expect(order).not_to be_valid
      expect(order.errors[:description]).to include('is too long (maximum is 500 characters)')
    end
  end

  describe 'token generation' do
    it 'generates a secure token before save' do
      expect(order.token).to be_nil
      order.save
      expect(order.token).not_to be_nil
    end
  end

  describe 'coingate_response=' do
    it 'merges the new value with the existing coingate_response value' do
      existing_value = { "some_key" => 'existing_value' }
      new_value = { 'new_key' => 'new_value' }

      order.coingate_response = existing_value
      expect(order.coingate_response).to eq(existing_value)

      order.coingate_response = new_value
      expect(order.coingate_response).to eq(existing_value.merge(new_value))
    end
  end
end
