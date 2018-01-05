class TweetController < ApplicationController
  include TweetHelper

  def index
    tweets = $client.user_timeline('rubyinside', count: 3)
    p tweets
    p "*****"
    tweets.each do |tweet|
      p tweet
       tweet.full_text

    end

  end

end
