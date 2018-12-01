require 'net/https'

class SearchController < ApplicationController
  before_action :set_empty_book

  # GET /search/index
  def index
  end

  # GET /search/search
  # GET /search/search.json
  # POST /search/search
  def search
    fetch(params[:keywd])

    respond_to do |format|
      format.html { render 'search/index' }
      format.json { render json: @books, status: :ok }
    end
  end

  private
    def set_empty_book
      @books = Array[Book.new(largeimage_url: "")]
    end

    def get_apikey
      return Apikey.first.key
    end

    def fetch(word)
      params = URI.encode_www_form({applicationId: get_apikey, format: 'json', formatVersion: 2, keyword: word, hits: 20, page: 1, sort: 'standard'})
      uri = URI.parse("https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?#{params}")
      logger.debug('test logger')
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
          @books = Array.new
          @result["Items"].each do |item|
            @books << extract_item(item)
          end
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

    def extract_item(item)
      return Book.new(
        title: item["title"],
        price: item["itemPrice"],
        author: item["author"],
        publisher: item["publisherName"],
        isbn: item["isbn"],
        caption: item["itemCaption"],
        sales_date: item["salesDate"],
        item_url: item["itemUrl"],
        largeimage_url: item["largeImageUrl"]
      )
    end

end
