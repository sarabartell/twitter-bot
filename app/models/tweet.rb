class Tweet < ApplicationRecord
  include TweetHelper
  attr_reader :dictionary

  def initialize()
    @dictionary = {}
  end

  def parse_tweets(params)
    twitter_handle = params["twitter_handle"]
    twitter_handle = 'realDonaldTrump' if (twitter_handle == nil || twitter_handle == "")

    @tweet_texts = []
      tweets = $client.user_timeline(twitter_handle, count: 40)
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
      tweets_to_markov(@tweet_texts)
      generate_sentence
  end

  def tweets_to_markov(tweets)
    tweets.each_with_index do |word, i|
      if i <= (tweets.count)
        add_to_markov(word, tweets[i+1])
       end
    end
    @dictionary
  end

  def sentence_end(word)
    if word =~ /^*+[?.!]$/
      true
    else
      false
    end
  end

  def add_to_markov(word, next_word)
    if !@dictionary[word]
      @dictionary[word] = Hash.new(0)
    end
    @dictionary[word][next_word] += 1
    @dictionary
  end

  def generate_sentence
    sentence = []
    sentence_starters = @dictionary.select {|k,v| k == nil}
    sentence << current_word = sentence_starters[nil].to_a.reject{|word| sentence_end(word)}.sample[0]

    until sentence_end(current_word) == true
      key_word = @dictionary.fetch(current_word)
      next_word = key_word.to_a[0][0]

      return sentence.join(" ") if next_word == nil

      if key_word.length > 1
        if key_word.values.uniq == [1]
         next_word = key_word.to_a.sample[0]
        else
          next_word = key_word.max_by{|k,v| v }[0]
        end
        sentence << next_word
        current_word = next_word

      elsif key_word.length == 1
        sentence << next_word
        current_word = next_word
      end
    end
    p sentence.join(" ")
  end

#last end
end
