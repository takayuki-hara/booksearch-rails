class Api::V1::UsersController < ApiController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate!, only: [:login, :create]

  # POST /users/login
  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      render json: @user
    else
      render json: { errors: ['ログインに失敗しました'] }, status: 401
    end
  end

  # GET /users
  def index
    render json: @users = User.all
  end

  # GET /users/me
  def me
    render json: current_user
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    # APIで作成したユーザーはmember権限
    @user.role = 1

    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    render json: { message: ['削除しました'] }, status: 200
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.permit(:username, :password, :password_confirmation, :role, :email, :fcm_token, :enable_email_notify, :enable_fcm_notify)
  end
end
