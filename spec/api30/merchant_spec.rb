require "cielo/api30/merchant"

describe Cielo::API30::Merchant do
  subject { described_class.new("123", "ABC") }

  describe "#initialize" do
    it "should set the attributes based on the given code" do
      expect(subject.merchant_id).to eql("123")
      expect(subject.merchant_key).to eql("ABC")
    end
  end
end