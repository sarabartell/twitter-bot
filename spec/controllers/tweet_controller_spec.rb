require 'rails_helper'

describe TweetController do
  let!(:tweets) {Tweet.new}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status 200
    end

    it "assigns tweets to @tweets" do
      get :index
      expect(assigns(:tweets)).to eq(@tweets)
    end

    it "generates an array of 10 tweets" do
      expect(@tweets.length).to eq(40)
    end
  end


end
