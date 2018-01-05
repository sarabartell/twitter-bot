class Tweet < ApplicationRecord
  include TweetHelper

  def initialize
    @dictionary = {}
    @all_tweets = parse_tweets
    @all_tweets.each_with_index do |word, i|
      if i <= (@all_tweets.count)
        add_to_markov(word, @all_tweets[i+1])
       end
    end
    p @dictionary
    p "******"
  end

  def parse_tweets
    @tweet_texts = []
    tweets = $client.user_timeline('ThePeakyBlinder', count: 30)
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
    @tweet_texts
  end

  def sentence_end(word)
    word =~ /^*+[?.!]$/
  end

  def add_to_markov(word, next_word)
    if !@dictionary[word]
      @dictionary[word] = Hash.new(0)
    end
    @dictionary[word][next_word] += 1
  end

  def generate_sentence(words_hash)
    sentence = []
  end

end
