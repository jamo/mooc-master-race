class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :admin?, :applicant?, :apprentice?, :imported?

  before_filter :auth!

  def auth!
    return if current_user
    redirect_to login_path
  end

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    elsif session[:applicant_token]
      Applicant.find_by(key: session[:applicant_token])
    elsif session[:imported_token]
      ImportedUser.find_by(key: session[:imported_token])
    end
  end

  def admin?
    return nil unless session[:user_id]
    user = User.find(session[:user_id])
    user && user.admin?
  end

  def apprentice?
    return nil unless session[:user_id]
    user = User.find(session[:user_id])
    user && user.apprentice?
  end

  def applicant?
    return nil unless session[:applicant_token]
    Applicant.find_by(key: session[:applicant_token])
  end

  def imported?
    return nil unless session[:imported_token]
    ImportedUser.find_by(key: session[:imported_token])
  end

  def respond_not_found(msg = 'Not Found')
    respond_with_error(msg, 404)
  end

  def respond_access_denied(msg = 'Access denied')
    respond_with_error(msg, 403)
  end

  def respond_with_error(msg, code = 500, extra_json_keys = {})
    respond_to do |format|
      format.html { render :text => '<p class="error">' + ERB::Util.html_escape(msg) + '</p>', :layout => true, :status => code }
      format.json { render :json => { :error => msg }.merge(extra_json_keys), :status => code }
      format.text { render :text => 'ERROR: ' + msg, :status => code }
      format.zip { render :text => msg, :status => code, :content_type => 'text/plain' }
    end
  end
end
