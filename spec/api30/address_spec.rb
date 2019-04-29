require "cielo/api30/address"

describe Cielo::API30::Address do
  subject { described_class.from_json("{\"Street\":\"123\"}") }
  let(:json) { "{\"Street\":\"123\"}" }

  describe "#to_json" do
    it "should return a json" do
      expect(subject.to_json).to eql(json)
    end
  end

  describe "#from_json" do
    it "should return a object" do
      expect(Cielo::API30::Address.from_json(json).class).to eql(subject.class)
    end
  end

  describe "#as_json" do
    it "should have the same value" do
      expect(subject.as_json.has_key?(:Street)).to be_truthy
    end
  end
end