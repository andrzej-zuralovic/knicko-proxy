# frozen_string_literal: true
module Api
  module V1
    module Params
      module PaymentCallback
        extend Grape::API::Helpers

        params :callback_params do
          requires :order_id, type: String, desc: 'Custom order ID of the merchant. Should be used to identify order or invoice number.'
          requires :status, type: String, desc: 'CoinGate payment status.'
          requires :token, type: String, desc: 'Your custom token (or generated by CoinGate) to validate payment callback.'

          optional :id, type: Integer, desc: 'CoinGate order (invoice) ID.'
          optional :price_amount, type: BigDecimal, desc: 'The price set by the merchant; for example, 499.95.'
          optional :price_currency, type: String, desc: 'The currency code which defines the currency in which the merchant\'s goods/services are priced; for example, USD, CHF, BTC (see supported currencies).'
          optional :receive_currency, type: String, desc: 'The currency code which defines the currency in which the merchant\'s settlements will be paid. Currency conversions are done by CoinGate automatically. For example: EUR, USD, BTC, USDT, etc.'
          optional :receive_amount, type: BigDecimal, desc: 'The amount which will be credited to the merchant when the invoice is paid. It is calculated by taking the price amount (converted to currency units set in receive_currency) and subtracting CoinGate processing fee from it.'
          optional :pay_amount, type: BigDecimal, desc: 'The amount of cryptocurrency (defined by pay_currency) paid by the shopper.'
          optional :pay_currency, type: String, desc: 'The cryptocurrency in which the payment was made; for example, BTC, LTC, ETH.'
          optional :underpaid_amount, type: BigDecimal, desc: 'The amount of cryptocurrency (defined by pay_currency) underpaid by the shopper. Changes in underpaid_amount will not trigger additional callbacks, but when order information is retrieved using GET or LIST, the latest value will be shown.'
          optional :overpaid_amount, type: BigDecimal, desc: 'The amount of cryptocurrency (defined by pay_currency) overpaid by the shopper. Changes in overpaid_amount will not trigger additional callbacks, but when order information is retrieved using GET or LIST, the latest value will be shown.'
          optional :is_refundable, type: Boolean, desc: 'Possible values: true, false. Indicates whether or not the shopper can request a refund on the invoice. Changes in is_refundable will not trigger additional callbacks, but when order information is retrieved using GET or LIST, the latest value will be shown.'
          optional :created_at, type: DateTime, desc: 'Invoice creation time.'
          optional :fees, type: Array, desc: 'Array of fees for Paid/Refunded/Partially refunded order'
        end
      end
    end
  end
end
