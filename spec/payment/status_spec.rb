require "cielo/api30/payment/status"

describe Cielo::API30::Payment::Status do
  let(:success) { described_class.success?(0) }

  describe "#client" do
    it "should return the same object" do
      expect(success).to be_falsey
    end
  end
end