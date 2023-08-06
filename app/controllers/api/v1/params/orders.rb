# frozen_string_literal: true
module Api
  module V1
    module Params
      module Orders
        extend Grape::API::Helpers

        params :create_order_params do
          requires :price_amount, type: BigDecimal, desc: 'The price. Example: 1050.99.'
          requires :price_currency, type: String, desc: 'ISO 4217 currency code which defines the currency in which you wish to price your merchandise.'
          requires :receive_currency, type: String, desc: 'ISO 4217 currency code which defines the currency in which you wish to receive your settlements.'

          optional :order_id, type: String, desc: "Custom order ID. Example: CGORDER-12345."
          optional :title, type: String, desc: 'Example: product title (Apple iPhone 6), order id (MyShop Order #12345)'
          optional :description, type: String, desc: 'More details about this order.'
          optional :cancel_url, type: String, desc: 'Redirect to Merchant URL when the buyer cancels the order.'
          optional :success_url, type: String, desc: 'Redirect to Merchant URL after a successful payment.'
          optional :purchaser_email, type: String, desc: "Email address of the purchaser (payee) provided will be pre-filled on the invoice."
        end
      end
    end
  end
end
