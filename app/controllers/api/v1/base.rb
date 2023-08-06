module Api
  module V1
    class Base < Grape::API
      version 'v1'
      format :json

      helpers do
        def authenticate!
          authorization_header = headers['Authorization']
          error!('401 Unauthorized', 401) if authorization_header.nil?

          bearer_match = authorization_header.match(/^Bearer (.+)$/)
          error!('401 Unauthorized', 401) unless bearer_match && bearer_match[1].eql?(Rails.env.test? ? 'test' : Rails.application.credentials.auth_token)
        end

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
        host: URI.parse(Rails.configuration.app_host).host,
        hide_documentation_path: true,
        add_version: true,
      })
    end
  end
end
