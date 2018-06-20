class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by(name: params[:name])
    @prototypes = @tag.prototypes.includes(:user).order("created_at ASC").page(params[:page]).per(5)

    # 他のコントローラーのアクションへ飛ばしたい場合は下記の記述。
    # 今回、飛んだ先で同フォルダ内の部分テンプレートを呼び出している為、使用しない。
    # render template: "prototypes/index"
  end
end
