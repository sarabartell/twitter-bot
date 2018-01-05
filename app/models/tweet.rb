class Tweet < ApplicationRecord
  include TweetHelper

  def parse_tweets
    @tweet_texts = []
    tweets = $client.user_timeline('NASA', count: 10)
    tweets.each do |tweet|
      tweet.full_text.split(" ").each do |word|
        if sentence_end(word)
          @tweet_texts << word
          @tweet_texts << nil
        else
          @tweet_texts << word
        end
      end
    end
    p @tweet_texts
  end

  def sentence_end(word)
    word =~ /^*+[?.!]$/
  end

  def generate_markov

  end

end
