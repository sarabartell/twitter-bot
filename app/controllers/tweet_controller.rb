class TweetController < ApplicationController
 include TweetHelper

  def index
    @tweets = Tweet.new
    @tweets.generate_sentence
  end

end
