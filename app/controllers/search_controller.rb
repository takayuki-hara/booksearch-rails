class SearchController < ApplicationController

  # GET /search/index
  def index
  end

  # GET /search/books
  # GET /search/books.json
  # POST /search/books
  def search
    @keywd = params[:keywd]
    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end
    searcher = BookSearcher.new
    @result = searcher.search(@keywd, @page, params[:genre])
    @books = searcher.get_books
    @message = searcher.get_message

    respond_to do |format|
      format.html { render 'search/index' }
      format.json { render json: @books, status: :ok }
    end
  end

  # POST /search/favorite
  def favorite
    prm = Book.new(book_params)
    book = Book.find_by(title: prm.title)

    # 書籍をDBに登録
    unless book.present?
      if prm.save
        book = prm
      else
        @type = "error"
        @msg = "パラメーターエラー"
        # return
      end
    end

    favorite = Favorite.find_by(user_id: @current_user.id, book_id: book.id)
    if favorite.present?
      @type = "info"
      @msg = "登録済みです"
    else
      # お気に入りを登録する
      fav = Favorite.new(user_id: @current_user.id, book_id: book.id)
      if fav.save
        @type = "success"
        @msg = "登録しました"
      else
        @type = "warning"
        @msg = "登録できませんでした"
      end
    end
  end

  # POST /search/watch
  def watch
    @type = "warning"
    @msg = "未実装です"
  end

  private

  def book_params
    params.permit(:title, :genres, :price, :author, :publisher, :isbn, :caption, :sales_date, :item_url, :largeimage_url)
  end

end
