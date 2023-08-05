module Api
  module V1
    class Orders < Grape::API
      resource :orders do
        desc 'Create Order'
        params do
          requires :price_amount, type: BigDecimal
          requires :price_currency, type: String
          requires :receive_currency, type: String

          optional :order_id, type: String
          optional :title, type: String
          optional :description, type: String
          optional :cancel_url, type: String
          optional :success_url, type: String
          optional :purchaser_email, type: String
        end
        post do
          order_params = declared_params

          order_params[:order_id] ||= SecureRandom.uuid

          new_order = Order.new(order_params)
          if new_order.save
            coingate_params = {
              price_amount: new_order.price_amount,
              price_currency: new_order.price_currency,
              receive_currency: new_order.receive_currency,

              order_id: new_order.order_id,
              title: new_order.title,
              description: new_order.description,
              callback_url: Rails.configuration.app_host + '/api/v1/payment_callback',
              cancel_url: new_order.cancel_url,
              success_url: new_order.success_url,
              purchaser_email: new_order.purchaser_email,
              token: new_order.token,
            }

            coingate_response = CoingateApi.new.create_order(coingate_params)

            if coingate_response.success?
              new_order.update(status: coingate_response.body['status'], coingate_response: coingate_response.body)
              new_order.reload
            else
              error!({ error: coingate_response.body['errors'] })
            end
          else
            error!({ error: new_order.errors })
          end
        end

        namespace '/:id', requirements: { id: /[0-9]*/ } do
          before do
            @order = Order.find_by(id: params[:id])

            error!('The requested order was not found.', :not_found) unless @order
          end

          desc 'Get Order'
          get do
            @order
          end
        end
      end
    end
  end
end
