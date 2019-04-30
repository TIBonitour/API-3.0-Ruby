require 'cielo/api30'

describe Cielo::API30 do
  subject { described_class.client('123') }
  let(:merchant) { described_class.merchant('123', '123') }

  describe '#client' do
    it 'should return the same object' do
      expect(Cielo::API30::Client.new('123').class).to eql(subject.class)
    end
  end

  describe '#client' do
    it 'should return the same object' do
      expect(Cielo::API30::Merchant.new('123', '123').class).to eql(merchant.class)
    end
  end
end
