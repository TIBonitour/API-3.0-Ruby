module Cielo
  module API30
    class Sale
      attr_accessor :merchant_order_id,
                    :customer,
                    :payment,
                    :response

      def initialize(merchant_order_id = nil)
        @merchant_order_id = merchant_order_id
        @customer = Customer.new
        @payment = Payment.new
        @response = Response.new
      end

      def to_json(*options)
        hash = as_json(*options)
        hash.to_json(*options)
      end

      def to_parsed_json
        JSON.generate(as_json)
      end

      def self.from_json(data)
        return if data.nil?

        data = JSON.parse(data)
        sale = new(data['MerchantOrderId'])
        sale.customer = data['Customer'].nil? ? Customer.new : Customer.from_json(JSON.generate(data['Customer']))
        sale.payment = data['Payment'].nil? ? Payment.new : Payment.from_json(JSON.generate(data['Payment']))
        sale.response = data['Response'].nil? ? Response.new : Response.from_json(JSON.generate(data['Response']))
        sale
      end

      def as_json(_options = {})
        remove_nulls(
          MerchantOrderId: @merchant_order_id,
          Customer: @customer.as_json,
          Payment: @payment.as_json,
          Response: @response.as_json
        )
      end

      def remove_nulls(hash)
        hash.reject { |_k, v| v.nil? || v.eql?('null') || v.eql?({}) }
      end
    end
  end
end
