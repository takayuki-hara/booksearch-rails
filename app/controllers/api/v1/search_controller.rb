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
    @message = searcher.get_message

    # TODO: エラーの場合の処理、件数などを返すためのリファクタ
    render json: @result, status: :ok
  end

end
