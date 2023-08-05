# frozen_string_literal: true

class CoingateApi
  attr_reader :client

  def initialize
    @client = Faraday.new(url: Rails.configuration.coingate_api_url) do |f|
      f.request(:json)
      f.request(:authorization, 'Token', Rails.application.credentials.dig(:coingate, :token))
      f.response(:json)
    end
  end

  def create_order(params)
    @client.post('orders', params)
  end

  def find_order(id)
    @client.get("orders/#{id}")
  end
end
