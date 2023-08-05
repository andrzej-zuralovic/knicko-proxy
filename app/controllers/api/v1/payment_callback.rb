module Api
  module V1
    class PaymentCallback < Grape::API
      resource :payment_callback do
        desc 'Payment Callback', hidden: true
        params do
          optional :id, type: Integer
          optional :order_id, type: String
          optional :status, type: String
          optional :price_amount, type: BigDecimal
          optional :price_currency, type: String
          optional :receive_currency, type: String
          optional :receive_amount, type: BigDecimal
          optional :pay_amount, type: BigDecimal
          optional :pay_currency, type: String
          optional :underpaid_amount, type: BigDecimal
          optional :overpaid_amount, type: BigDecimal
          optional :is_refundable, type: Boolean
          optional :created_at, type: DateTime
          optional :token, type: String
          optional :fees, type: Array
        end
        post do
          if (order = Order.find_by(order_id: declared_params[:order_id], token: declared_params[:token]))
            order.update(status: declared_params[:status], coingate_response: declared_params)
          end

          status(:ok)
        end
      end
    end
  end
end
