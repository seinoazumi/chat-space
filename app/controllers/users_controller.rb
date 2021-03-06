class UsersController < ApplicationController
  # before_action :set_group, only:[:index]

  def index
    @users = User.where('name LIKE(?)', "%#{params[:search]}%").limit(20).where.not(id: current_user.id)
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def edit
  end

  def flash_login
    flash[:login] = "ログインしました。"
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
