require 'spec_helper'

RSpec.describe Twirloc::TwitterClient do
  describe "#guess_location" do
    before do
      @username = "davetroy"
      @client = described_class.new
      @guesser = double(:guesser, location: "Philadelphia, PA")
      allow_any_instance_of(Twirloc::LocationGuesser).to receive_messages(new: @guesser, location: "Philadelphia, PA")
    end

    it "returns a location for a given user" do
      location = @client.guess_location(@username)
      expect(location).to eq("Philadelphia, PA")
    end
  end

  # Check profile location
  # Check all tweets for geo metadata
  # Avg location from followers and following
end
