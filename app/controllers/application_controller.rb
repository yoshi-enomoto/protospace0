class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインアウト後のリダイレクト先を設定
  def after_sign_out_path_for(resource)
    root_path
  end

  # サインアップ時の追加項目用のストパラ設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :position, :occupation, :avatar])

    devise_parameter_sanitizer.permit(:account_update, keys:[:name, :profile, :position, :occupation, :avatar])
  end

end
