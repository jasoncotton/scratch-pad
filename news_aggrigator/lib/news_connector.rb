module NewsWrapper
  class Article
    attr_accessor :title, :url, :source, :position
    def initialize(params = {})
      @title = params[:title] || 'No title provided'
      @url = params[:url] || 'No url provided'
      @source = params[:source] || 'unknown'
      @position = params[:position] || -1
    end
  end
end

class NewsConnector
  ## Base Class to handle the base connection between this news aggregator and the sites to aggregate news from.
  attr_accessor :url

  def initialize
    @url= get_url()
  end

  def get_url; end

  def get_data(url=@url)
    if (url =~ /https/) then
      require 'net/https'

      url = URI.parse(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url.request_uri)
      response = http.request(request)
      response.body
    else
      require 'net/http'

      url = URI.parse(url)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end
      res.body
    end
  end

  def get_top_stories
    transform(get_data())
  end

  def transform(data)
    # implement this in inherited classes
  end

end

