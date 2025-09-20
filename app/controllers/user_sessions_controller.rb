class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to new_diary_path, success: "ログインに成功しました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to intro_path, success: "ログアウトに成功しました", status: :see_other
  end
end
