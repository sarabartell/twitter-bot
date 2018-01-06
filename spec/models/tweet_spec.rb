require 'rails_helper'


describe Tweet do
  let(:tweet) { Tweet.new }


  describe "initialization of tweet" do
    it "has dictionary as an empty hash" do
      tweet.dictionary
      expect(tweet.dictionary).to eq {}
    end
  end

  describe "sentence_end"do
    it "matches true if a sentence contains the regex pattern" do
      word = "Congrats!"
      expect(tweet.sentence_end(word)).to eq true
    end

    it "matches false if a sentence doesn't contain the regex pattern" do
      word = "Cat"
      expect(tweet.sentence_end(word)).to eq false
    end
  end

  describe "tweet_to_markov" do
    it "returns a hash of parsed data" do
      tweets = ["are", "giving", "big", "bonuses", "to", "their", "workers", "because", "of", "the", "Tax", "Cut", "Bill.", nil, "Really", "great!", nil, "Thank", "you", "to", "Brandon", "Judd", "of", "the", "National", "Border", "Patrol", "Council", "for", "your", "kind", "words", "on", "how", "well", "we", "are", "doing", "at", "the…", "https://t.co/tmH3s3Q91a", "Crooked", "Hillary", "Clinton’s", "top", "aid,", "Huma", "Abedin,", "has", "been", "accused", "of", "disregarding", "basic", "security", "protocols.", nil, "She", "put…", "https://t.co/TAM3Zf9ovm", "The", "people", "of", "Iran", "are", "finally", "acting", "against", "the", "brutal", "and", "corrupt", "Iranian", "regime.", nil, "All", "of", "the", "money", "that", "Presiden…", "https://t.co/AjDsIsx0Gk", "Will", "be", "leaving", "Florida", "for", "Washington", "(D.C.)", "today", "at", "4:00", "P.M.", nil, "Much", "work", "to", "be", "done,", "but", "it", "will", "be", "a", "great", "New", "Year!", nil, "Iran", "is", "failing", "at", "every", "level", "despite", "the", "terrible", "deal", "made", "with", "them", "by", "the", "Obama", "Administration.", nil, "The", "great", "Iran…", "https://t.co/DaPjy8hPH5", "The", "United", "States", "has", "foolishly", "given", "Pakistan", "more", "than", "33", "billion", "dollars", "in", "aid", "over", "the", "last", "15", "years,", "and", "they…", "https://t.co/TuiaWGtnbR", "HAPPY", "NEW", "YEAR!", nil, "We", "are", "MAKING", "AMERICA", "GREAT", "AGAIN,", "and", "much", "faster", "than", "anyone", "thought", "possible!", nil, "As", "our", "Country", "rapidly", "grows", "stronger", "and", "smarter,", "I", "want", "to", "wish", "all", "of", "my", "friends,", "supporters,", "enemies,", "haters,", "a…", "https://t.co/irAgm3wwEU", "Iran,", "the", "Number", "One", "State", "of", "Sponsored", "Terror", "with", "numerous", "violations", "of", "Human", "Rights", "occurring", "on", "an", "hourly", "basi…", "https://t.co/EHq72J2QaP", "What", "a", "year", "it’s", "been,", "and", "we're", "just", "getting", "started.", nil, "Together,", "we", "are", "MAKING", "AMERICA", "GREAT", "AGAIN!", nil, "Happy", "New", "Year!!", nil, "https://t.co/qsMNyN1UJG"]
      expect(tweet.tweets_to_markov(tweets).is_a?(Hash)).to eq true
    end
  end

  describe "generate sentence" do
    it "returns a string" do
      tweets = ["are", "giving", "big", "bonuses", "to", "their", "workers", "because", "of", "the", "Tax", "Cut", "Bill.", nil, "Really", "great!", nil, "Thank", "you", "to", "Brandon", "Judd", "of", "the", "National", "Border", "Patrol", "Council", "for", "your", "kind", "words", "on", "how", "well", "we", "are", "doing", "at", "the…", "https://t.co/tmH3s3Q91a", "Crooked", "Hillary", "Clinton’s", "top", "aid,", "Huma", "Abedin,", "has", "been", "accused", "of", "disregarding", "basic", "security", "protocols.", nil, "She", "put…", "https://t.co/TAM3Zf9ovm", "The", "people", "of", "Iran", "are", "finally", "acting", "against", "the", "brutal", "and", "corrupt", "Iranian", "regime.", nil, "All", "of", "the", "money", "that", "Presiden…", "https://t.co/AjDsIsx0Gk", "Will", "be", "leaving", "Florida", "for", "Washington", "(D.C.)", "today", "at", "4:00", "P.M.", nil, "Much", "work", "to", "be", "done,", "but", "it", "will", "be", "a", "great", "New", "Year!", nil, "Iran", "is", "failing", "at", "every", "level", "despite", "the", "terrible", "deal", "made", "with", "them", "by", "the", "Obama", "Administration.", nil, "The", "great", "Iran…", "https://t.co/DaPjy8hPH5", "The", "United", "States", "has", "foolishly", "given", "Pakistan", "more", "than", "33", "billion", "dollars", "in", "aid", "over", "the", "last", "15", "years,", "and", "they…", "https://t.co/TuiaWGtnbR", "HAPPY", "NEW", "YEAR!", nil, "We", "are", "MAKING", "AMERICA", "GREAT", "AGAIN,", "and", "much", "faster", "than", "anyone", "thought", "possible!", nil, "As", "our", "Country", "rapidly", "grows", "stronger", "and", "smarter,", "I", "want", "to", "wish", "all", "of", "my", "friends,", "supporters,", "enemies,", "haters,", "a…", "https://t.co/irAgm3wwEU", "Iran,", "the", "Number", "One", "State", "of", "Sponsored", "Terror", "with", "numerous", "violations", "of", "Human", "Rights", "occurring", "on", "an", "hourly", "basi…", "https://t.co/EHq72J2QaP", "What", "a", "year", "it’s", "been,", "and", "we're", "just", "getting", "started.", nil, "Together,", "we", "are", "MAKING", "AMERICA", "GREAT", "AGAIN!", nil, "Happy", "New", "Year!!", nil, "https://t.co/qsMNyN1UJG"]
      tweet.tweets_to_markov(tweets)
      expect(tweet.generate_sentence.is_a?(String)).to eq true
    end
  end

  describe "add to markov" do
    it "creates a new hash if word doesnt exist" do
      @dictionary = {}
      expect(tweet.add_to_markov("we","are").is_a?(Hash)).to eq true
    end
  end

end
