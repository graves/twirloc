require 'spec_helper'

RSpec.describe Twirloc::GoogleLocation do
  it "can be initialized with api_key" do
    locator = described_class.new(api_key: "fake_key", coords: [666, 69])
    expect(locator.api_key).to eq("fake_key")
  end
end
