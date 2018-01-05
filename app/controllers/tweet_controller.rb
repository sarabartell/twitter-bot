class TweetController < ApplicationController
 include TweetHelper

  def index
    @tweets = Tweet.new
    @tweets.parse_tweets
    # tweetzz.generate_tweets
  end

end
