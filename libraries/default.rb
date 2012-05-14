require 'open-uri'
require 'rubygems'
require 'json'
require 'test/unit'


TW = 'https://api.twitter.com/1/statuses/user_timeline.json?screen_name='

# Connects to twitter, retrieves tweets for screen_name.
def get_tweets(screen_name)
  open(TW + screen_name, 'r'){ |t| JSON(t.read) }
end

# Writes tweet out to /etc/motd.
def write_motd(tweet)
  open('/etc/motd', 'w'){ |m| m.write(tweet) }
end


class TestMOTDLibrary < Test::Unit::TestCase
  def test_get_tweet
    tweets = get_tweets('ampledata')
    tweet = tweets.first['text']

    assert_kind_of(String, tweet)
    assert_match(/Ruby Testing/, tweet)
  end

  def test_write_motd
    tweets = get_tweets('georgetakei')
    tweet = tweets.first['text']

    write_motd(tweet)
    motd = open('/etc/motd').read

    assert_equal(tweet, motd)
  end
end
