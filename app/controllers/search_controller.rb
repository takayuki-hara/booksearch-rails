require 'net/https'

class SearchController < ApplicationController

  # GET /search/index
  def index
  end

  # GET /search/books
  # GET /search/books.json
  # POST /search/books
  def search
    fetch(params[:keywd])

    respond_to do |format|
      format.html { render 'search/index' }
      format.json { render json: @books, status: :ok }
    end
  end

  # POST /search/favorite
  def favorite
    # 書籍をDBに登録
    @book = Book.new(book_params)
    if Book.find_by(title: @book.title).present?
      @type = "warning"
      @msg = "登録済みです"
    else
      if @book.save
        @type = "success"
        @msg = "登録しました"
      else
        @type = "error"
        @msg = "登録できませんでした"
      end
    end

    # TODO: favoritesにも登録する
  end

  private
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

    def book_params
      params.permit(:title, :price, :author, :publisher, :isbn, :caption, :sales_date, :item_url, :largeimage_url)
    end

end
