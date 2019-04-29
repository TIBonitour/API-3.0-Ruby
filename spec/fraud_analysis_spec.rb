require "cielo/api30/fraud_analysis"

describe Cielo::API30::FraudAnalysis do
  subject { described_class.from_json("{\"Provider\":\"123\"}") }
  let(:json) { "{\"Provider\":\"123\"}" }

  describe "#to_json" do
    it "should return a json" do
      expect(subject.to_json).to eql(json)
    end
  end

  describe "#from_json" do
    it "should return a object" do
      expect(Cielo::API30::FraudAnalysis.from_json(json).class).to eql(subject.class)
    end
  end

  describe "#as_json" do
    it "should have the same value" do
      expect(subject.as_json.has_key?(:Provider)).to be_truthy
    end
  end
end