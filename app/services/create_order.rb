# frozen_string_literal: true

class CreateOrder
  def initialize(order_params)
    @order_params = order_params
  end

  def call
    order = Order.new(@order_params)
    order.order_id ||= SecureRandom.uuid

    raise(StandardError, format_error_messages(order.errors)) unless order.save

    order
  end

  private

  def format_error_messages(errors)
    errors.messages.transform_values { |messages| messages.join(', ') }
  end
end
