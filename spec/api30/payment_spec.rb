require 'cielo/api30/payment'

describe Cielo::API30::Payment do
  subject { described_class.new(123, 2) }
  let(:json) { '{"Installments":2,"Amount":123}' }

  describe '#initialize' do
    it 'should set the attributes based on the given code' do
      expect(subject.amount).to eql(123)
      expect(subject.installments).to eql(2)
    end
  end

  describe '#to_json' do
    it 'should return a json' do
      expect(subject.to_json).to eql(json)
    end
  end

  describe '#from_json' do
    it 'should return a object' do
      expect(Cielo::API30::Payment.from_json(json).class).to eql(subject.class)
    end
  end

  describe '#success?' do
    it 'should return a object' do
      subject.status = 1
      expect(subject.success?).to be_truthy
    end
  end

  describe '#as_json' do
    it 'should have the same value' do
      expect(subject.as_json.key?(:Amount)).to be_truthy
      expect(subject.as_json.key?(:Installments)).to be_truthy
    end
  end
end
