class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  def index
    @prototypes = Prototype.includes(:user).order("created_at ASC").page(params[:page]).per(5)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
      # これにより、ネストしているモデルのインスタンスを生成できる。
      # 逆にこれが無いと、ビュー側で『fields_for』が展開されない。
      # ビュー側で枚数（回数）を制限していない場合は、下記の書き方となる。
      # 3.times { @prototype.captured_images.build}
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
    @main = @prototype.captured_images.find_by(status: 0)
    @subs = @prototype.captured_images.where(status: 1)
    @prototype.captured_images.build
  end

  def update
    if current_user.id == @prototype.user.id
      @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: "更新が完了しました。"
    else
      flash.now[:alert] = "更新が完了しませんでした。"
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: "削除が完了しました。"
  end

  private
  def prototype_params
    # 『captured_images_attributes: [:content, :status]』の書き方でネストしているものが保存できる。
    # []内にネスト先の保存させるカラムを記載する。
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status]
    )
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
