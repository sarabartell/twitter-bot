class TweetController < ApplicationController
 include TweetHelper

  def index
    @tweets = Tweet.parse_tweets
  end

end
