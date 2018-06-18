class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  def index
    @prototypes = Prototype.includes(:user).order("created_at ASC").page(params[:page]).per(5)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
      # 3.times { @prototype.captured_images.build}
      # ビュー側で枚数（回数）を制限しているので、上の書き方はコメアウト。
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
        redirect_to root_path, notice: "投稿完了しました。"
    else
      flash.now[:alert] = "投稿が成功出来ませんでした。"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: "削除が完了しました。"
  end

  private
  def prototype_params
    # 『captured_images_attributes: [:content, :status]』の書き方でネストしているものが保存できる。
    # []内にネスト先の保存させるカラムを記載する。
    # 『:prototype_id』は記載しないで問題なし。（アソシエーション組んでいる為）
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status]
    )
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
