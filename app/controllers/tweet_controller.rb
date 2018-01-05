class TweetController < ApplicationController
 include TweetHelper

  def index
    @tweets = Tweet.new
  end

end
