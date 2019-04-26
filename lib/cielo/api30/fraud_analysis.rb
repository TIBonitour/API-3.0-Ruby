# -*- encoding : utf-8 -*-
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
                    :browser

      def to_json(*options)
        hash = as_json(*options)
        hash.reject! {|k,v| v.nil?}
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        fraud_analysis = new
        fraud_analysis.provider = data["Provider"]
        fraud_analysis.sequence = data["Sequence"]
        fraud_analysis.sequence_criteria = data["SequenceCriteria"]
        fraud_analysis.capture_on_low_risk = data["CaptureOnLowRisk"]
        fraud_analysis.void_on_high_risk = data["VoidOnHighRisk"]
        fraud_analysis.total_order_amount = data["TotalOrderAmount"]
        fraud_analysis.finger_print_id = data["FingerPrintId"]
        fraud_analysis.browser = data["Browser"]
        fraud_analysis
      end

      def as_json(options={})
        {
          Provider: @provider,
          Sequence: @sequence,
          SequenceCriteria: @sequence_criteria,
          CaptureOnLowRisk: @capture_on_low_risk,
          VoidOnHighRisk: @void_on_high_risk,
          TotalOrderAmount: @total_order_amount,
          FingerPrintId: @finger_print_id,
          Browser: @browser
        }
      end
    end
  end
end
