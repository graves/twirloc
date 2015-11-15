require 'twitter'
require 'dotenv'

module Twirloc
  class TwitterClient
    def initialize(args={})
      @token           ||= args[:access_token]
      @secret          ||= args[:secret]
      @consumer_key    ||= args[:consumer_key]
      @consumer_secret ||= args[:consumer_secret]

      client
    end

    def authenticated?
      client.user_token?
    end

    def user_tweet_count(username)
      client.user(username).tweets_count
    end

    def user_geo_enabled?(username)
      client.user(username).geo_enabled?
    end

    def guess_location(username)
      LocationGuesser.new(username).location
    end

    def method_missing(method_name, *arguments, &block)
      if Twitter::REST::Client.public_instance_methods.include?(method_name)
        client.public_send(method_name, *arguments, &block)
      else
        super
      end
    end

    def respond_to_missing(method_name, include_private = false)
      Twitter::REST::Client.public_instance_methods.include? method_name || super
    end

    private

    def client
      @_client = authenticate
    end

    def authenticate
      if @token && @secret && @consumer_key && @consumer_secret
        @_client = Twitter::REST::Client.new do |config|
          config.consumer_key        = @consumer_key
          config.consumer_secret     = @consumer_secret
          config.access_token        = @token
          config.access_token_secret = @secret
        end
      else
        Dotenv.load

        @_client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
          config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
          config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
          config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
        end
      end

      @_client
    end
  end
end

