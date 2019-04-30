require 'cielo/api30/environment'

describe Cielo::API30::Environment do
  subject { described_class.new('123', '123') }

  describe '#initialize' do
    it 'should return the same values' do
      expect(subject.api).to eql('123')
      expect(subject.api_query).to eql('123')
    end
  end

  describe '#production' do
    it 'should return the same values' do
      expect(Cielo::API30::Environment.production.api).to eql('https://api.cieloecommerce.cielo.com.br/')
      expect(Cielo::API30::Environment.production.api_query).to eql('https://apiquery.cieloecommerce.cielo.com.br/')
    end
  end

  describe '#sandbox' do
    it 'should return the same values' do
      expect(Cielo::API30::Environment.sandbox.api).to eql('https://apisandbox.cieloecommerce.cielo.com.br/')
      expect(Cielo::API30::Environment.sandbox.api_query).to eql('https://apiquerysandbox.cieloecommerce.cielo.com.br/')
    end
  end
end
