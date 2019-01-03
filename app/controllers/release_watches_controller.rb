class ReleaseWatchesController < ApplicationController
  before_action :set_release_watch, only: [:show, :edit, :update, :destroy]

  # GET /release_watches
  # GET /release_watches.json
  def index
    # 管理者は全ユーザー、メンバーは自分の情報だけ見える
    if @current_user.role == 0
      @release_watches = ReleaseWatch.all
    else
      @release_watches = ReleaseWatch.where(user_id: @current_user.id)
    end
  end

  # GET /release_watches/1
  # GET /release_watches/1.json
  def show
  end

  # GET /release_watches/new
  def new
    @release_watch = ReleaseWatch.new
  end

  # GET /release_watches/1/edit
  def edit
  end

  # POST /release_watches
  # POST /release_watches.json
  def create
    @release_watch = ReleaseWatch.new(release_watch_params)

    respond_to do |format|
      if @release_watch.save
        format.html { redirect_to @release_watch, notice: 'Release watch was successfully created.' }
        format.json { render :show, status: :created, location: @release_watch }
      else
        format.html { render :new }
        format.json { render json: @release_watch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /release_watches/1
  # PATCH/PUT /release_watches/1.json
  def update
    respond_to do |format|
      if @release_watch.update(release_watch_params)
        format.html { redirect_to @release_watch, notice: 'Release watch was successfully updated.' }
        format.json { render :show, status: :ok, location: @release_watch }
      else
        format.html { render :edit }
        format.json { render json: @release_watch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /release_watches/1
  # DELETE /release_watches/1.json
  def destroy
    @release_watch.destroy
    respond_to do |format|
      format.html { redirect_to release_watches_url, notice: 'Release watch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_release_watch
    @release_watch = ReleaseWatch.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def release_watch_params
    params.require(:release_watch).permit(:user_id, :book_id, :sales_date)
  end
end
