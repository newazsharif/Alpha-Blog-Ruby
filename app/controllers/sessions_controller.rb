class SessionsController < ApplicationController
  def new
    
  end
  def create
     user = User.find_by_email(params[:session][:email].downcase)
     if user && user.authenticate(params[:session][:password])
       session[:user_id] = user.id
       session[:username] = user.username
       flash[:success] = "user logged in successfully"
       redirect_to user_path(user)
     else
       flash.now[:danger] = "Please provide valid login information!!!"
       render 'new'
     end
    
  end
  def destroy 
    session[:user_id] = nil
    flash[:success] = "user logged out successfully"
    redirect_to root_path
  end
end