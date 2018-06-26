class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    # ここを通る時は、『:id』が『:prototype_id』に変化している。
    # @like = Like.crate(user_id: current_user.id, prototype_id: params[:prototype_id])
    @like = Like.new(user_id: current_user.id, prototype_id: params[:prototype_id])

    if @like.save
      @prototype = Prototype.find(params[:prototype_id])
      # 『format.js』の記述は無くても動作する
    else
      flash.now[:alert] = "likeエラー"
      @prototype = prototype.find(params[:prototype_id])
      render "prototypes/show"
    end
  end

  def destroy
    # # 閲覧prototypeへのlikeを取り消す為の、likeレコードを検索・取得
    like = Like.find_by(user_id: current_user.id, prototype_id: params[:prototype_id])

    if like.destroy
      @prototype = Prototype.find(params[:prototype_id])
      # 『format.js』の記述は無くても動作する
    else
      flash.now[:alert] = "unlikeエラー"
      @prototype = prototype.find(params[:prototype_id])
      render "prototypes/show"
    end
  end
end
