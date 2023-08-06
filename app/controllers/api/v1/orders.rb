module Api
  module V1
    class Orders < Grape::API
      helpers Api::V1::Params::Orders

      resource :orders do
        before { authenticate! }

        desc 'Create Order', {
          headers: {
            "Authorization" => {
              description: "Bearer token auth in headers. Example: Bearer xxxxx",
              required: true,
            },
          },
          consumes: ['multipart/form-data'],
        }
        params do
          use :create_order_params
        end
        post do
          order = CreateOrder.new(declared_params).call

          CreateCoingateOrder.new(order).call
        rescue StandardError => e
          error!({ error: e.message })
        end

        namespace '/:id', requirements: { id: /[0-9]*/ } do
          before do
            @order = Order.find_by(id: params[:id])

            error!('The requested order was not found.', :not_found) unless @order
          end

          desc 'Get Order', {
            headers: {
              "Authorization" => {
                description: "Bearer token auth in headers. Example: Bearer xxxxx",
                required: true,
              },
            },
          }
          get do
            @order
          end
        end
      end
    end
  end
end
