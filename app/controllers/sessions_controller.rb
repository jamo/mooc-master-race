class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path(user), notice: "Welcome!"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:applicant_id] = nil
  end

end
