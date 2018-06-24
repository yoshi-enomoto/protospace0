class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      @prototype = Prototype.find(params[:prototype_id])
      @comments = @prototype.comments
      @comment_counts = @comments.length

      respond_to do |format|
        format.html { redirect_to prototype_path(@comment.prototype_id)}
        # フォーム『remote: true』により、リクエストはAjaxリクエストでやってくる。
        # jsを探しているので、下記を記述することでコントローラが応答可能となる。
        # 対応するファイルは、『アクション.js.erb』となる。
        format.js
      end
    else
      flash.now[:alert] = "コメントが投稿出来ませんでした。"
      @tags = @prototype.tags
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    # 『require』で指定した内部に入っているキーは、あくまでもモデルに沿ったもののみ。
    # なので、『user_id』や『prototype_id』などはmergeで持ってくる。（ネスト）
  end
end

