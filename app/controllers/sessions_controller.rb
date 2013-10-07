class SessionsController < ApplicationController
  def create
    session[:password] = params[:password]
    flash[:notice] = "Logged in!"
    redirect_to polls_path
  end

  def destroy
    reset_session
    flash[:notice] = "Logged out!"
    redirect_to polls_path
  end
end
