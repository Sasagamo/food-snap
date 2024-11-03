class UsersController < ApplicationController
  before_action :set_user, only:[:show,:edit,:update]
  before_action :check_user, only: [:edit]


  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報が更新されました。' 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user =User.find(params[:id])
  end

  def check_user
    return if @user.id == current_user.id
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:nickname,:account_name,:bio,:avatar)
  end
end
