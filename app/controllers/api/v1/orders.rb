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
          order_params[:callback_url] = Rails.configuration.app_host + '/api/v1/payment_callback'
          coingate_response = CoingateApi.new.create_order(order_params)

          if coingate_response.success?
            coingate_response.body
          else
            error!({ error: coingate_response.body['errors'] })
          end
        end

        namespace '/:id', requirements: { id: /[0-9]*/ } do
          desc 'Get Order'
          get do
            coingate_response = CoingateApi.new.find_order(params[:id])
            if coingate_response.success?
              coingate_response.body
            else
              error!({ error: coingate_response.body })
            end
          end
        end
      end
    end
  end
end
