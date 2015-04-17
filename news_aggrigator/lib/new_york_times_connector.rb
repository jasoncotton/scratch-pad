require 'news_connector'
require 'pp'

class NewYorkTimesConnector < NewsConnector
  def get_url
    api_key = '2358dfdb138cf77098a7b5343bebd91f:1:71690325'
    return "http://api.nytimes.com/svc/topstories/v1/home.json?api-key=#{api_key}"
  end

  def transform(data)
    count = 0
    transformed = []
    json = JSON.parse data

    if (json['status'] == 'OK') then
      count = json['num_results']
      json['results'].each_with_index do |result, index|
        transformed.push(
          NewsWrapper::Article.new(
            {
              title: result['title'],
              url: result['url'],
              source: 'nyt',
              position: index

            }
          )
        )
      end
    end
    transformed
  end
end