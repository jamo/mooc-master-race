class SessionsController < ApplicationController
  skip_before_filter :auth!

  def new
    @user = User.new
  end

  def create
    user = User.where(username: params[:user][:username]).first
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      return redirect_to interview_days_path, notice: "Welcome!" if user.apprentice?
      redirect_to applicants_path, notice: "Welcome!"
    else
      flash[:error] = "Invalid Username or Password" unless flash[:error]
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def magic
    user = User.where(key: params[:key]).first
    if user
      session[:user_id] = user.id
      return redirect_to interview_days_path, notice: "Welcome!" if user.apprentice?
      redirect_to applicants_path, notice: "Welcome!"
    else
      flash[:error] = "Invalid Username or Password" unless flash[:error]
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:applicant_token] = nil
    redirect_to login_path
  end

end
