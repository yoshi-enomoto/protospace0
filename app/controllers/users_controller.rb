class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  before_action :authenticate_user!, only: [:edit, :update]
  # ログイン済みのユーザーのみ、only以下のアクション実行可能。
  # 未ログイン時の場合は、サインインページへリダイレクトされる。

  def show
    @prototypes = @user.prototypes.includes(:user).order("created_at ASC").page(params[:page]).per(5)
  end

  def edit
  end

  def update
    # 『current_user』に対してupdateメソッドを使うと、1行で書ける。
    current_user.update(user_params)
    # 『before_action』に『update』を設定している場合、下記の記述でも良い。
    # @user = update(user_params)


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
