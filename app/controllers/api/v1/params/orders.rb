# frozen_string_literal: true
module Api
  module V1
    module Params
      module Orders
        extend Grape::API::Helpers

        params :create_order_params do
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
      end
    end
  end
end
