require 'spec_helper'

RSpec.describe Twirloc::LocationGuesser do
  it "can be initialized with a username" do
    guesser = described_class.new("dqt")
    expect(guesser.username).to eq("dqt")
  end

  it "can get a users profile location" do
    VCR.use_cassette("user_profile_location", record: :new_episodes) do
      guesser = described_class.new("davetroy")
      location = guesser.user_profile_location
      expect(location).to eq("Baltimore, MD")
    end
  end

  it "can get tweets with geolocation" do
    VCR.use_cassette("user_profile_location", record: :new_episodes) do
      guesser = described_class.new("davetroy")
      tweets = guesser.user_tweets_with_geolocation
      expect(tweets.first.coordinates).to eq([39.33090026, -76.6426334])
    end
  end
end
