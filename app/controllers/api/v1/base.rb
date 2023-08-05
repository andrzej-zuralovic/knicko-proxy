module Api
  module V1
    class Base < Grape::API
      version 'v1'
      format :json

      helpers do
        def declared_params
          declared(params, include_missing: false)
        end
      end

      mount Api::V1::Orders
      mount Api::V1::PaymentCallback

      add_swagger_documentation({
        info: { title: 'Knicko-CoinGate API Proxy' },
        api_version: '1.0.0',
        doc_version: '1.0.0',
        host: Rails.configuration.app_host,
        hide_documentation_path: true,
        add_version: true,
      })
    end
  end
end