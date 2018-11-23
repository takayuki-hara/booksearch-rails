require 'net/https'

class SearchController < ApplicationController
  def index
  end

  def search
    fetch(params[:keywd])
    render 'search/index'
  end

  private
    def get_apikey
      return Apikey.first.key
    end

    def fetch(word)
      params = URI.encode_www_form({applicationId: get_apikey, format: 'json', formatVersion: 2, keyword: word, hits: 20, page: 1, sort: 'standard'})
      uri = URI.parse("https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?#{params}")
      @query = uri.query

      # 新しくHTTPセッションを開始し、結果をresponseへ格納（Net::HTTPResponseのインスタンス）
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.open_timeout = 5
        http.read_timeout = 10
        http.get(uri.request_uri)
      end
      begin
        case response
        when Net::HTTPSuccess
          @result = JSON.parse(response.body)
          @title = @result["Items"][0]["title"]
          @price = @result["Items"][0]["price"]
          @author = @result["Items"][0]["author"]
          @largeimage_url = @result["Items"][0]["largeimage_url"]
        when Net::HTTPRedirection
          @message = "Redirection: code=#{response.code} message=#{response.message}"
        else
          @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
        end
      rescue IOError => e
        @message = "e.message"
      rescue TimeoutError => e
        @message = "e.message"
      rescue JSON::ParserError => e
        @message = "e.message"
      rescue => e
        @message = "e.message"
      end
    end
end
