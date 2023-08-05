module Api
  module V1
    class PaymentCallback < Grape::API
      helpers Api::V1::Params::PaymentCallback

      resource :payment_callback do
        desc 'Payment Callback', hidden: true
        params do
          use :callback_params
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
