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
    # @dictionary.each do |k,v|
    #   p "#{k} --> #{v}"
    # end

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
