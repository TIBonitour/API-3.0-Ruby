require 'cielo/api30/sale'

describe Cielo::API30::Sale do
  subject { described_class.new('123') }
  let(:json) { '{"MerchantOrderId":"123"}' }

  describe '#initialize' do
    it 'should set the attributes based on the given code' do
      expect(subject.merchant_order_id).to eql('123')
    end
  end

  describe '#to_json' do
    it 'should return a json' do
      expect(subject.to_json).to eql(json)
    end
  end

  describe '#to_parsed_json' do
    it 'should have the same result of to_json' do
      expect(subject.to_parsed_json).to eql(subject.to_parsed_json)
    end
  end

  describe '#from_json' do
    it 'should return a object' do
      expect(Cielo::API30::Sale.from_json(json).class).to eql(subject.class)
    end
  end

  describe '#as_json' do
    it 'should have the same value' do
      customer = Cielo::API30::Customer.new('Teste')
      payment = Cielo::API30::Payment.new(123)
      fraude = Cielo::API30::FraudAnalysis.from_json('{"Provider":"Cyber"}')
      subject.customer = customer
      subject.payment = payment
      subject.payment.fraud_analysis = fraude
      expect(subject.as_json.key?(:MerchantOrderId)).to be_truthy
      expect(subject.as_json.key?(:Customer)).to be_truthy
      expect(subject.as_json.key?(:Payment)).to be_truthy
      expect(subject.payment.as_json.key?(:FraudAnalysis)).to be_truthy
    end
  end
end
