# frozen_string_literal: true
module Api
  module V1
    module Params
      module PaymentCallback
        extend Grape::API::Helpers

        params :callback_params do
          requires :order_id, type: String
          requires :status, type: String
          requires :token, type: String

          optional :id, type: Integer
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
          optional :fees, type: Array
        end
      end
    end
  end
end
