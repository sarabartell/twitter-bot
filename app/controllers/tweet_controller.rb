class TweetController < ApplicationController
 include TweetHelper

  def index
    @tweets = Tweet.new
    # @tweet = tweets.parse_tweets(params[])
  end

end
