require 'spec_helper'

RSpec.describe Twirloc::Tweet do
  it "can be initialized with a tweet from the twitter client" do
    client_tweet = double(:tweet, text: "hey hi hello")
    twirloc_tweet = described_class.new(client_tweet)
    expect(twirloc_tweet.text).to eq("hey hi hello")
  end

  before do
    geo = double(:geo, coordinates: [666, 69])
    client_tweet = double(:tweet, geo?: true, geo: geo)
    @twirloc_tweet = described_class.new(client_tweet)
  end

  describe "#coordinates" do
    it "is an array of geolocation coordinates" do
      expect(@twirloc_tweet.coordinates).to eq([666, 69])
    end
  end

  describe "#longitude" do
    it "is the longitude coordinate" do
      expect(@twirloc_tweet.longitude).to eq(666)
    end
  end

  describe "#latitude" do
    it "is the latitude coordinate" do
      expect(@twirloc_tweet.latitude).to eq(69)
    end
  end
end
