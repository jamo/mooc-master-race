class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user, :admin?

  def current_user
    User.find(session[:user_id]) || Applicant.find(session[:applicant_token])
  end

  def admin?
    user = User.find(session[:user_id])
    user && user.admin?
  end


end
