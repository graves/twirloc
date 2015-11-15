require 'feature_helper'

$0 = 'twirloc'
ARGV.clear

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end

RSpec.describe Twirloc, :type => :feature do
  it "is testable" do
    stdout = capture(:stdout) { Twirloc::CLI.start }
    expect(stdout).to match("Commands:")
  end

  it "`total` returns total number of tweets for specified user", :vcr do
    VCR.use_cassette("total_tweet_count", record: :new_episodes) do
      stdout = capture(:stdout) { Twirloc::CLI.start(["total", "dqt"]) }
      expect(stdout).to match("1526")
    end
  end

  it "`geo` returns true if account has enabled geo location", :vcr do
    stdout = capture(:stdout) { Twirloc::CLI.start(["geo", "davetroy"]) }
    expect(stdout).to match("enabled")
  end

  it "`locate` returns best guest at a users location", :vcr do
    stdout = capture(:stdout) { Twirloc::CLI.start(["locate", "davetroy"]) }
    expect(stdout).to match("Philadelphia, PA")
  end

=begin
  it "`tweetmeta-locations` returns a list of coordinates from recent tweets", :vcr do
    coord_str =
      "Lat: 39.02795438\nLon: -76.50286074\n\nLat: 38.14964742\nLon: -79.06859706"
    stdout = capture(:stdout) { Twirloc::CLI.start(["tweetmeta-locations",
                                                    "davetroy"]) }
    expect(stdout).to match(coord_str)
  end
=end
end
