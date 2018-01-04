require 'twitter'
class TwitterApi < ApplicationRecord

  def twitter_api_access
    @client = Twitter::REST::Client.new do |config|
      config.cosumer_key = "CONSUMER_KEY"
      config.consumer_secret = "CONSUMER_SECRET"
      config.access_token = "ACCESS_TOKEN"
      config.access_token_secret = "ACCESS_SECRET"
    end
  end

  tweets = @client.user_timeline('rubyinside', count: 3)

  tweets.each { |tweet| p tweet.full_text }

end
