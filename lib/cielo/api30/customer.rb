module Cielo
  module API30
    # Customer data
    #
    # @attr [String] name Customer name
    # @attr [String] email Customer email
    # @attr [String] birthDate Customer's birth date
    # @attr [String] identity Customer id
    # @attr [String] identityType The type of customer id
    # @attr [Address] address Customer's address
    # @attr [Address] deliveryAddress The delivery address
    class Customer
      attr_accessor :name,
                    :email,
                    :birth_date,
                    :identity,
                    :identity_type,
                    :address,
                    :delivery_address

      def initialize(name = nil)
        @name = name
        @address = Address.new
        @delivery_address = Address.new
      end

      def to_json(*options)
        hash = as_json(*options)
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        data = JSON.parse(data)
        customer = new(data['Name'])
        customer.email = data['Email']
        customer.birth_date = data['BirthDate']
        customer.identity = data['Identity']
        customer.identity_type = data['IdentityType']
        customer.address = data['Address'].nil? ? Address.new : Address.from_json(JSON.generate(data['Address']))
        customer.delivery_address = data['DeliveryAddress'].nil? ? Address.new : Address.from_json(JSON.generate(data['DeliveryAddress']))
        customer
      end

      def as_json(_options = {})
        remove_nulls(
          Name: @name,
          Email: @email,
          BirthDate: @birth_date,
          Identity: @identity,
          IdentityType: @identity_type,
          Address: @address.as_json,
          DeliveryAddress: @delivery_address.as_json
        )
      end

      def remove_nulls(hash)
        hash.reject { |_k, v| v.nil? || v.eql?('null') || v.eql?({}) }
      end
    end
  end
end
