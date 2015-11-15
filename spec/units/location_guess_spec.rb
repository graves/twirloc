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

  it "can get geolocation of all tweets" do
    VCR.use_cassette("user_profile_location", record: :new_episodes) do
      guesser = described_class.new("davetroy")
      location = guesser.user_profile_location
      expect(location).to eq("Baltimore, MD")
    end
  end
end
