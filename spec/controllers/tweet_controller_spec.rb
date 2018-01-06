require 'rails_helper'

describe TweetController do
  let!(:tweets) {Tweet.new}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "redirects to index page" do
      get :index
      expect(response).to redirect_to tweet_index_path
    end
  end

end
