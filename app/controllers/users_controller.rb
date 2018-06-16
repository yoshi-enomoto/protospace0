class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def show
  end

  def edit
  end

  def update
    # 『current_user』に対してupdateメソッドを使うと、1行で書ける。
    current_user.update(user_params)

    redirect_to root_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :avatar,
      :profile,
      :position,
      :occupation
    )
  end
end
