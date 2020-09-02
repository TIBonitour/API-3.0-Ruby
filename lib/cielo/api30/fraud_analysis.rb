module Cielo
  module API30
    class FraudAnalysis
      attr_accessor :provider,
                    :sequence,
                    :sequence_criteria,
                    :capture_on_low_risk,
                    :void_on_high_risk,
                    :total_order_amount,
                    :finger_print_id,
                    :browser,
                    :fraud_analysis_reason_code,
                    :status_description,
                    :merchant_defined_fields

      def initialize
        @browser = Browser.new
      end

      def to_json(*options)
        hash = as_json(*options)
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        data = JSON.parse(data)
        fraud_analysis = new
        fraud_analysis.provider = data['Provider']
        fraud_analysis.sequence = data['Sequence']
        fraud_analysis.sequence_criteria = data['SequenceCriteria']
        fraud_analysis.capture_on_low_risk = data['CaptureOnLowRisk']
        fraud_analysis.void_on_high_risk = data['VoidOnHighRisk']
        fraud_analysis.total_order_amount = data['TotalOrderAmount']
        fraud_analysis.finger_print_id = data['FingerPrintId']
        fraud_analysis.browser = data['Browser'].nil? ? Browser.new : Browser.from_json(JSON.generate(data['Browser']))
        fraud_analysis.merchant_defined_fields = data['MerchantDefinedFields'].nil? ? [] : data['MerchantDefinedFields']
        fraud_analysis.fraud_analysis_reason_code = data["FraudAnalysisReasonCode"]
        fraud_analysis.status_description = data["StatusDescription"]
        fraud_analysis
      end

      def as_json(_options = {})
        remove_nulls(
          Provider: @provider,
          Sequence: @sequence,
          SequenceCriteria: @sequence_criteria,
          CaptureOnLowRisk: @capture_on_low_risk,
          VoidOnHighRisk: @void_on_high_risk,
          TotalOrderAmount: @total_order_amount,
          FingerPrintId: @finger_print_id,
          Browser: @browser.as_json,
          FraudAnalysisReasonCode: @fraud_analysis_reason_code,
          StatusDescription: @status_description,
          MerchantDefinedFields: @merchant_defined_fields
        )
      end

      def remove_nulls(hash)
        hash.reject { |_k, v| v.nil? || v.eql?('null') || v.eql?({}) || v.eql?([]) }
      end
    end
  end
end
