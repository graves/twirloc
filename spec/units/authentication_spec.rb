require 'spec_helper'

RSpec.describe Twirloc::TwitterClient do
  context "API keys in ENV" do
    it "successfully authenticates with twitter" do
      twitter = described_class.new
      expect(twitter.authenticated?).to eq(true)
    end
  end

  #context "API keys not in ENV" do
  #end
end
