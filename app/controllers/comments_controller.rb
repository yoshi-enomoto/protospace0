class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to prototype_path(@comment.prototype_id), notice: "コメント投稿完了"
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

