class Api::V1::SearchController < ApiController

  # GET /search
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
    # APIのレスポンスのItemsの部分をBookクラスの配列で置き換える
    @result["Items"] = @books
    @message = searcher.get_message

    # TODO: エラーの場合の処理
    render json: @result, status: :ok
  end

end
