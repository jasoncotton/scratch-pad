require 'news_connector'
require 'pp'

class HackerNewsConnector < NewsConnector
  def get_url
    return 'https://hacker-news.firebaseio.com/v0/topstories.json'
  end

  def get_item_url(item)
    "https://hacker-news.firebaseio.com/v0/item/#{item}.json"
  end

  def transform(data)
    count = 0
    transformed = []
    json = JSON.parse data
    (0..10).each do |index|
      item_response = JSON.parse get_data(get_item_url(json[index]))
      transformed.push(
         NewsWrapper::Article.new(
             {
               title: item_response['title'],
               url: item_response['url'],
               source: 'hn',
               position: index
            }
         )
      )
    end
    transformed
  end
end