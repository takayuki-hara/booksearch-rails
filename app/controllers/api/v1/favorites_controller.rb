class Api::V1::FavoritesController < ApiController
  before_action :set_favorite, only: [:update, :destroy]

  # GET /favorites
  def index
    # 自分の情報だけ見える
    @favorites = Favorite.where(user_id: current_user.id)
    render 'favorites'
    # render json: @favorites
  end

  # POST /favorites
  def create
    prm = Book.new(book_params)
    book = Book.find_by(title: prm.title)

    # 書籍をDBに登録
    unless book.present?
      if prm.save
        book = prm
      else
        render json: { message: ["パラメーターエラー"] }, status: 200
      end
    end

    favorite = Favorite.find_by(user_id: current_user.id, book_id: book.id)
    if favorite.present?
      render json: { message: ["登録済みです"] }, status: 200
    else
      # お気に入りを登録する
      fav = Favorite.new(user_id: @current_user.id, book_id: book.id)
      if fav.save
        render json: fav
      else
        render json: { message: [@msg] }, status: :unprocessable_entity
      end
    end
  end

  # DELETE /favorites/1
  def destroy
    @favorite.destroy
    render json: { message: ['削除しました'] }, status: 200
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def book_params
    params.permit(:title, :genres, :price, :author, :publisher, :isbn, :caption, :sales_date, :item_url, :largeimage_url)
  end
end
