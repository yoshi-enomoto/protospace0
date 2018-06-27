class NewestsController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end
end
