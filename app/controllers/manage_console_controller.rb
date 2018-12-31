class ManageConsoleController < ApplicationController
  def index
    # 管理画面は管理者しかアクセスさせない
    if @current_user.role != 0
      redirect_to top_index_url
    end
  end
end
