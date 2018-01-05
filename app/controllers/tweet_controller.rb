class TweetController < ApplicationController
 include TweetHelper

  def index
    tweets = Tweet.new
    @tweet = tweets.generate_sentence
  end

end
