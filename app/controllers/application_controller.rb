class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_logined

  private

  def check_logined
    if session[:usr] then
      begin
        @current_user = User.find(session[:usr])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    unless @current_user
      flash[:referer] = request.fullpath
      redirect_to controller: :login, action: :index
    end
  end
end
