module Cielo
  module API30
    class Response
      attr_accessor :code

      def to_json(*options)
        hash = as_json(*options)
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        data = JSON.parse(data)
        response = new
        response.code = data['Code']
        response
      end

      def as_json(_options = {})
        remove_nulls(
          Code: @code
        )
      end

      def remove_nulls(hash)
        hash.reject { |_k, v| v.nil? || v.eql?('null') }
      end
    end
  end
end
