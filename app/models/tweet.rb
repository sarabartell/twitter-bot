class Tweet < ApplicationRecord
  include TweetHelper

  def self.parse_tweets
    @tweet_texts = []
    tweets = $client.user_timeline('rubyinside', count: 10)
    tweets.each do |tweet|
      @tweet_texts << tweet.full_text
    end
    p @tweet_texts
  end

  def generate_tweets(tweet_array)

  end

end
