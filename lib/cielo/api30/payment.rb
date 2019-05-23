require 'cielo/api30/payment/status'
require 'cielo/api30/return_info'

module Cielo
  module API30
    class Payment
      PAYMENTTYPE_CREDITCARD = 'CreditCard'.freeze
      PAYMENTTYPE_DEBITCARD = 'DebitCard'.freeze
      PAYMENTTYPE_ELECTRONIC_TRANSFER = 'ElectronicTransfer'.freeze
      PAYMENTTYPE_BOLETO = 'Boleto'.freeze

      PROVIDER_BRADESCO = 'Bradesco'.freeze
      PROVIDER_BANCO_DO_BRASIL = 'BancoDoBrasil'.freeze
      PROVIDER_SIMULADO = 'Simulado'.freeze

      attr_accessor :service_tax_amount,
                    :installments,
                    :interest,
                    :capture,
                    :authenticate,
                    :recurrent,
                    :recurrent_payment,
                    :credit_card,
                    :debit_card,
                    :proof_of_sale,
                    :authorization_code,
                    :soft_descriptor,
                    :return_url,
                    :provider,
                    :payment_id,
                    :tid,
                    :type,
                    :amount,
                    :received_date,
                    :captured_amount,
                    :captured_date,
                    :currency,
                    :country,
                    :return_code,
                    :return_message,
                    :status,
                    :links,
                    :extra_data_collection,
                    :expiration_date,
                    :url,
                    :number,
                    :bar_code_number,
                    :digitable_line,
                    :address,
                    :return_info,
                    :authentication_url,
                    :fraud_analysis

      def initialize(amount = nil, installments = nil)
        @amount = amount
        @installments = installments
        @recurrent_payment = RecurrentPayment.new
        @credit_card = CreditCard.new
        @debit_card = DebitCard.new
        # @return_info = ReturnInfo.new(0)
        @fraud_analysis = FraudAnalysis.new
      end

      def to_json(*options)
        hash = as_json(*options)
        hash.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        data = JSON.parse(data)
        payment = new(data['Amount'])
        payment.service_tax_amount = data['ServiceTaxAmount']
        payment.installments = data['Installments']
        payment.interest = data['Interest']
        payment.capture = data['Capture']
        payment.authenticate = data['Authenticate']
        payment.recurrent = data['Recurrent']
        payment.recurrent_payment = data['RecurrentPayment'].nil? ? RecurrentPayment.new : RecurrentPayment.from_json(JSON.generate(data['RecurrentPayment']))
        payment.credit_card = data['CreditCard'].nil? ? CreditCard.new : CreditCard.from_json(JSON.generate(data['CreditCard']))
        payment.debit_card = data['DebitCard'].nil? ? DebitCard.new : DebitCard.from_json(JSON.generate(data['DebitCard']))
        payment.proof_of_sale = data['ProofOfSale']
        payment.authorization_code = data['AuthorizationCode']
        payment.soft_descriptor = data['SoftDescriptor']
        payment.return_url = data['ReturnUrl']
        payment.provider = data['Provider']
        payment.payment_id = data['PaymentId']
        payment.tid = data['Tid']
        payment.type = data['Type']
        payment.received_date = data['ReceivedDate']
        payment.captured_amount = data['CapturedAmount']
        payment.captured_date = data['CapturedDate']
        payment.currency = data['Currency']
        payment.country = data['Country']
        payment.return_code = data['ReturnCode']
        payment.return_message = data['ReturnMessage']
        payment.status = data['Status']
        payment.authentication_url = data['AuthenticationUrl']
        payment.links = data['Links']
        payment.extra_data_collection = data['ExtraDataCollection']
        payment.expiration_date = data['ExpirationDate']
        payment.url = data['Url']
        payment.number = data['Number']
        payment.bar_code_number = data['BarCodeNumber']
        payment.digitable_line = data['DigitableLine']
        payment.address = data['Address']
        # payment.return_info = data['ReturnInfo'].nil? ? ReturnInfo.new : ReturnInfo.from_json(JSON.generate(data['ReturnInfo']))
        payment.fraud_analysis = data['FraudAnalysis'].nil? ? FraudAnalysis.new : FraudAnalysis.from_json(JSON.generate(data['FraudAnalysis']))
        payment
      end

      def success?
        Status.success?(status)
      end

      def as_json(_options = {})
        remove_nulls(
          ServiceTaxAmount: @service_tax_amount,
          Installments: @installments,
          Interest: @interest,
          Capture: @capture,
          Authenticate: @authenticate,
          Recurrent: @recurrent,
          RecurrentPayment: @recurrent_payment.as_json,
          CreditCard: @credit_card.as_json,
          DebitCard: @debit_card.as_json,
          SoftDescriptor: @soft_descriptor,
          ReturnUrl: @return_url,
          Provider: @provider,
          Type: @type,
          Amount: @amount,
          Currency: @currency,
          Country: @country,
          Number: @number,
          BarCodeNumber: @bar_code_number,
          DigitableLine: @digitable_line,
          Address: @address,
          # ReturnInfo: @return_info.as_json,
          FraudAnalysis: @fraud_analysis.as_json
        )
      end

      def safe_json
        as_json.merge(CreditCard: @credit_card.safe_json, DebitCard: @debit_card.safe_json)
      end

      def remove_nulls(hash)
        hash.reject { |_k, v| v.nil? || v.eql?('null') || v.eql?({}) }
      end
    end
  end
end
