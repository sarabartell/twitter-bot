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
    @dictionary
  end

  def parse_tweets
    @tweet_texts = []
    tweets = $client.user_timeline('realDonaldTrump', count: 40)
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
  end

  def generate_sentence
    sentence = []
    next_word = ""
    sentence_starters = @dictionary.select {|k,v| k == nil}
    sentence << current_word = sentence_starters[nil].to_a.reject{|word| sentence_end(word)}.sample[0]

    until sentence_end(current_word) == true
      @dictionary.fetch(current_word)
      #finds values of the word in dictionary
      next_word = @dictionary.fetch(current_word).to_a[0][0]
      #sets next word to that key
      return sentence.join(" ") if next_word == nil
      #stops and returns sentence if next word is nil
      sentence << next_word
      #otherwise, shuffles in next word to sentence
      current_word = next_word
      #resets current word to the next word
      if @dictionary.fetch(current_word).length > 1
        sentence << current_word = @dictionary.fetch(current_word).max_by{|k,v| v }[0]
        #returns the max key by the highest value
      end
    end
    p sentence.join(" ")
  end

end
