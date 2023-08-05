# frozen_string_literal: true

class CreateCoingateOrder
  CALLBACK_URL = Rails.configuration.app_host + '/api/v1/payment_callback'

  def initialize(order)
    @order = order
  end

  def call
    coingate_params = {
      price_amount: @order.price_amount,
      price_currency: @order.price_currency,
      receive_currency: @order.receive_currency,

      order_id: @order.order_id,
      title: @order.title,
      description: @order.description,
      callback_url: CALLBACK_URL,
      cancel_url: @order.cancel_url,
      success_url: @order.success_url,
      purchaser_email: @order.purchaser_email,
      token: @order.token,
    }

    coingate_response = CoingateApi.new.create_order(coingate_params)
    handle_coingate_response(coingate_response)
  end

  private

  def handle_coingate_response(response)
    if response.success?
      @order.update(status: response.body['status'], coingate_response: response.body)
      @order.reload
    else
      raise StandardError, response.body['errors']
    end
  end
end
