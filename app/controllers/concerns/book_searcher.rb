require 'net/https'

class BookSearcher

  def search(word, page, genre_id)
    if genre_id.present?
      genre = genre_id
    else
      genre = 'null'
    end
    Rails.logger.debug('BookSearcher::search() genre=' + genre)
    params = URI.encode_www_form({applicationId: get_apikey, format: 'json', formatVersion: 2, keyword: word, hits: 20, page: page, booksGenreId: genre, sort: '-releaseDate'})
    uri = URI.parse("https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?#{params}")
    
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.open_timeout = 5
      http.read_timeout = 10
      http.get(uri.request_uri)
    end
    begin
      case response
      when Net::HTTPSuccess
        @result = JSON.parse(response.body)
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
    return @result
  end

  def get_books
    books = Array.new
    @result["Items"].each do |item|
      books << extract_item(item)
    end
    return books
  end

  def get_message
    return @message
  end

  def extract_item(item)
    return Book.new(
      title: item["title"],
      genres: extract_genre(item["booksGenreId"]),
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

  private

  def get_apikey
    return Apikey.first.key
  end

  def extract_genre(param)
    genres = param.split("/")
    result = Array.new
    genres.each do |genre|
      result << genre[0,6]
    end
    return result.uniq
  end
end