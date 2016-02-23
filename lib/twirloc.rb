require "twirloc/version"
require "twirloc/twitter_client"
require "twirloc/location_guesser"
require "twirloc/tweet_fetcher"
require "twirloc/tweet"
require "twirloc/midpoint_calculator"
require "twirloc/algorithms"
require "twirloc/google_location"
require "thor"

module Twirloc
  class CLI < Thor
    desc "total USERNAME", "get total number of tweets for USERNAME"
    def total(username)
      twitter = TwitterClient.new
      tweet_count = twitter.user_tweet_count(username)
      puts tweet_count
    end

    desc "geo USERNAME", "checks if profile is geo enabled for USERNAME"
    def geo(username)
      twitter = TwitterClient.new
      enabled = twitter.user_geo_enabled?(username)
      puts enabled ? "enabled" : "disabled"
    end

    desc "geocenter_user_tweets USERNAME", "calculates geographic centerpoint of any lat/lon coordinates from tweets by USERNAME"
    def geocenter_user_tweets(username)
      twitter = TwitterClient.new
      location = twitter.user_tweets_geo_center(username)
      puts location
    end

    desc "locate USERNAME", "takes best guess at users location"
    def locate(username)
      twitter = TwitterClient.new
      location = twitter.guess_location(username)
      puts location
    end
  end
end
