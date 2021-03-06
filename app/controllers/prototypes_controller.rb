class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  def index
    # Popularを表示する為に、DESC用のカラムを変更
    @prototypes = Prototype.includes(:user).order("likes_count DESC").page(params[:page]).per(5)
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

    tag_list = params[:prototype][:tag_list]
    # tag_list = params[:tag_list].split(",")
    # 『:tag_list』って何？=ビューのformで入力される際に設定しているname属性の値
    # 『.split』は引数で指定したものを区切りの対象とし、配列にして返す。その為、元の値は『string』である事が条件。
    # なので、ビュー側でname属性値を『prototype[tag_list][]』に設定し、paramsに入ってくる値を上記の形で配列で取り出す。

    if @prototype.save
      @prototype.save_prototypes(tag_list)
      # モデルで定義したメソッドを実行
      redirect_to root_path, notice: "投稿完了しました。"
    else
      flash.now[:alert] = "投稿が成功出来ませんでした。"
      render :new
    end
  end

  def show
    @tags = @prototype.tags
    @comment = Comment.new
    @comments = @prototype.comments
    @comment_counts = @comments.length
    if user_signed_in?
    # if user_signed_in? && Like.exists?(prototype_id: params[:id], user_id: current_user.id)
    # 『exists?(引数)』で引数の条件にあったものが存在しているか判定する。
    # 返り値はfalse or true。
      @like = Like.find_by(user_id: current_user.id, prototype_id: params[:id])
    end
  end

  def edit
    @main = @prototype.captured_images.find_by(status: 0)
    @subs = @prototype.captured_images.where(status: 1)
    @prototype.captured_images.build
    @tag_list = @prototype.tags.pluck(:name)
    @length = 3 - @tag_list.length
  end

  def update
    tag_list = params[:prototype][:tag_list]

    if current_user.id == @prototype.user.id
      @prototype.update(prototype_params)
      @prototype.save_prototypes(tag_list)
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
      # tag_ids: [],
      captured_images_attributes: [:id, :content, :status]
    )
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
