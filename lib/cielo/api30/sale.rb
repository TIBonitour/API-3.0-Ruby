# -*- encoding : utf-8 -*-
module Cielo
  module API30
    class Sale
      attr_accessor :merchant_order_id,
                    :customer,
                    :payment,
                    :fraud_analysis

      def initialize(merchant_order_id)
        @merchant_order_id = merchant_order_id
      end

      def to_json(*options)
        hash = as_json(*options)
        hash.reject! {|k,v| v.nil?}
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?
        data = JSON.parse(data)
        sale = new(data["MerchantOrderId"])
        sale.customer = Customer.from_json(JSON.generate(data["Customer"])) unless data["Customer"].nil?
        sale.payment = Payment.from_json(JSON.generate(data["Payment"])) unless data["Payment"].nil?
        sale.fraud_analysis = FraudAnalysis.from_json(JSON.generate(data["FraudAnalysis"])) unless data["FraudAnalysis"].nil?
        sale
      end

      def as_json(options={})
        {
          MerchantOrderId: @merchant_order_id,
          Customer: @customer,
          Payment: @payment,
          FraudAnalysis: @fraud_analysis
        }
      end
    end
  end
end
