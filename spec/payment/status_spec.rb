require "cielo/api30/payment/status"

describe Cielo::API30::Payment::Status do
  let(:zero) { described_class.success?(0) }
  let(:um) { described_class.success?(1) }

  describe "#success?" do
    it "should return false" do
      expect(zero).to be_falsey
    end
  end

  describe "#success?" do
    it "should return true" do
      expect(um).to be_truthy
    end
  end
end