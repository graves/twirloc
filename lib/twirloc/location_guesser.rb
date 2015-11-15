module Twirloc
  class LocationGuesser
    attr_reader :username, :client
    #@profile_location = user_profile_location(username)
    #@geolocations_of_tweets = user_tweet_geolocations(username)
    #@geolocations_of_followers_tweets = follower_tweet_geolocations(username)
    #@geolocations_of_followings_tweets = following_tweet_geolocations(username)
    #avg_follow = avg_follow_locations(@geolocations_of_followers_tweets, @geolocations_of_followings_tweets)

    def initialize(username)
      @username ||= username
      @client ||= TwitterClient.new
    end

    def locate
    end

    def user_profile_location
      client.user(username).location || ""
    end
  end
end
