class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :admin?

  before_filter :auth!

  def auth!
    return if current_user
    redirect_to login_path
  end

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    elsif session[:applicant_token]
      Applicant.find(session[:applicant_token])
    end
  end

  def admin?
    user = User.find(session[:user_id])
    user && user.admin?
  end

end
