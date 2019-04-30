module Cielo
  module API30
    # Credit card data
    #
    # @attr [String] card_number Credit card number
    # @attr [String] holder Holder name
    # @attr [String] expiration_date Credit card expiration date
    # @attr [String] security_code Credit card security code
    # @attr [Boolean] save_card Whether or not to save the card
    # @attr [String] brand Credit card brand
    # @attr [String] card_token Card token
    class CreditCard
      attr_accessor :card_number,
                    :holder,
                    :expiration_date,
                    :security_code,
                    :save_card,
                    :brand,
                    :card_token

      def initialize(args = {})
        @security_code = args[:security_code]
        @brand = args[:brand]
        @card_token = args[:token]
      end

      def to_json(*options)
        hash = as_json(*options)
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        data = JSON.parse(data)
        credit_card = new
        credit_card.card_number = data['CardNumber']
        credit_card.holder = data['Holder']
        credit_card.expiration_date = data['ExpirationDate']
        credit_card.security_code = data['SecurityCode']
        credit_card.save_card = data['SaveCard']
        credit_card.brand = data['Brand']
        credit_card.card_token = data['CardToken']
        credit_card
      end

      def as_json(_options = {})
        remove_nulls(
          CardNumber: @card_number,
          Holder: @holder,
          ExpirationDate: @expiration_date,
          SecurityCode: @security_code,
          SaveCard: @save_card,
          Brand: @brand,
          CardToken: @card_token
        )
      end

      def remove_nulls(hash)
        hash.reject { |_k, v| v.nil? || v.eql?('null') || v.eql?({}) }
      end
    end
  end
end
