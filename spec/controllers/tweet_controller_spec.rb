require 'spec_helper'
require_relative 'tweet_controller'

RSpec.describe TweetController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "generates an array of 10 tweets" do
      expect(@tweets.length).to eq(10)
    end
  end


end
