class Api::V1::UsersController < ApiController
  skip_before_action :authenticate!, only: [:login]

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      render json: @user
    else
      render json: { errors: ['ログインに失敗しました'] }, status: 401
    end
  end

  def me
    render json: current_user
  end

end
