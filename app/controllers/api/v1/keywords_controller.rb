class Api::V1::KeywordsController < ApiController
  before_action :set_keyword, only: [:show, :update, :destroy]

  # GET /keywords
  def index
    # 自分の情報だけ見える
    @keywords = Keyword.where(user_id: current_user.id)
    render json: @keywords
  end

  # GET /keywords/1
  def show
    render json: @keyword
  end

  # POST /keywords
  def create
    @keyword = Keyword.new(keyword_params)
    @keyword.user_id = current_user.id
    @keyword.item_count = 0

    if @keyword.save
      render json: @keyword
    else
      render json: @keyword.errors, status: :unprocessable_entity
    end
  end

  # PUT /keywords/1
  def update
    if @keyword.update(keyword_params)
      render json: @keyword
    else
      render json: @keyword.errors, status: :unprocessable_entity
    end
  end

  # DELETE /keywords/1
  def destroy
    @keyword.destroy
    render json: { message: ['削除しました'] }, status: 200
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_keyword
    @keyword = Keyword.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def keyword_params
    params.permit(:keyword, :genre)
  end
end
