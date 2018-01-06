class TweetController < ApplicationController
 include TweetHelper

  def index
    tweets = Tweet.new
    @tweet_search = tweets.parse_tweets(twitter_handle_params)
  end

  private

  def twitter_handle_params
    params.permit(:twitter_handle, :controller)
  end

end
