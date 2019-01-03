class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:destroy]

  # GET /favorites
  # GET /favorites.json
  def index
    # 管理者は全ユーザー、メンバーは自分の情報だけ見える
    if @current_user.role == 0
      @favorites = Favorite.all
    else
      @favorites = Favorite.where(user_id: @current_user.id)
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to favorites_url, notice: 'Favorite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

end
