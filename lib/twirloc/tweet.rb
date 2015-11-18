module Twirloc
  class Tweet

    attr_reader :twitter_tweet

    def initialize(twitter_tweet)
      @twitter_tweet = twitter_tweet
    end

    def text
      twitter_tweet.text
    end

    def coordinates
      twitter_tweet.geo.coordinates
    end

    def longitude
      coordinates[0]
    end

    def latitude
      coordinates[1]
    end

  end
end
