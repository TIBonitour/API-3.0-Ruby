require 'uuidtools'
require 'json'
require 'net/http'

require 'cielo/api30/request/cielo_error'

module Cielo
  module API30
    module Request
      class CieloRequest
        attr_accessor :merchant, :response_body
        private :merchant

        def initialize(merchant)
          @merchant = merchant
        end

        protected

        def send_request(method, uri, data = nil)
          body = nil
          headers = { 'User-Agent' => 'CieloEcommerce/3.0 Ruby SDK',
                      'RequestId' => UUIDTools::UUID.random_create.to_s,
                      'MerchantId' => merchant.merchant_id,
                      'MerchantKey' => merchant.merchant_key }

          if data.nil?
            headers['Content-Length'] = '0'
          else
            headers['Content-Type'] = 'application/json'
            body = data.to_json
          end

          client = Net::HTTP.new(uri.host, uri.port)
          client.use_ssl = true

          response = client.send_request(method, uri.request_uri, body, headers)

          self.response_body = JSON.parse(response.body)

          raise CieloError.new(response_body.first['Code'], response_body.first['Message']) if response.code.to_i >= 400

          JSON.parse(response.body).merge!(Response: { Code: response.code.to_i }).to_json
        end
      end
    end
  end
end
