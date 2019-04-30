module Cielo
  module API30
    class Browser
      attr_accessor :cookies_accepted,
                    :email,
                    :ip_address

      def to_json(*options)
        hash = as_json(*options)
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        data = JSON.parse(data)
        browser = new
        browser.cookies_accepted = data['CookiesAccepted']
        browser.email = data['Email']
        browser.ip_address = data['IpAddress']
        browser
      end

      def as_json(_options = {})
        remove_nulls(
          CookiesAccepted: @cookies_accepted,
          Email: @email,
          IpAddress: @ip_address
        )
      end

      def remove_nulls(hash)
        hash.reject { |_k, v| v.nil? || v.eql?('null') || v.eql?({}) }
      end
    end
  end
end
