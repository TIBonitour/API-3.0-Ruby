# -*- encoding : utf-8 -*-
module Cielo
  module API30
    class RecurrentPayment
      INTERVAL_MONTHLY = "Monthly"
      INTERVAL_BIMONTHLY = "Bimonthly"
      INTERVAL_QUARTERLY = "Quarterly"
      INTERVAL_SEMIANNUAL = "SemiAnnual"
      INTERVAL_ANNUAL = "Annual"

      attr_accessor :authorize_now,
                    :start_date,
                    :end_date,
                    :interval,
                    :recurrent_payment_id,
                    :next_recurrency,
                    :link

      def initialize(authorize_now=true)
        @authorize_now = authorize_now
      end

      def to_json(*options)
        hash = as_json(*options)
        hash.reject! {|k,v| v.nil?}
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?
        data = JSON.parse(data)
        recurrent_payment = new(data["AuthorizeNow"])
        recurrent_payment.start_date =data["StartDate"]
        recurrent_payment.end_date =data["EndDate"]
        recurrent_payment.interval =data["Interval"]
        recurrent_payment.recurrent_payment_id =data["RecurrentPaymentId"]
        recurrent_payment.next_recurrency =data["NextRecurrency"]
        recurrent_payment.link =data["Link"]
        recurrent_payment
      end

      def as_json(options={})
        {
          AuthorizeNow: @authorize_now,
          StartDate: @start_date,
          EndDate: @end_date,
          Interval: @interval
        }
      end
    end
  end
end
