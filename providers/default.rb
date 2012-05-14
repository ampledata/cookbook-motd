require 'open-uri'
require 'rubygems'
require 'json'


action :create do
  tweets = get_tweets(new_resource.name)
  write_motd(tweets.first['text'])
  new_resource.updated_by_last_action(true)
end
