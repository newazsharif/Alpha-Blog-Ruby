class UsersController < ApplicationController
  
  
  # before_action :set_user, :only => [:edit,:update,:show]
  
  before_action :require_user, :except => [:index, :create, :new]
  before_action :admin_only, :only => [:destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page:5 )
  end
  
  def new
    @user = User.new
  end
  
  
  def destroy
    @user = User.find(params[:id])
    
    @user.destroy
    flash[:danger] = "User deleted successfully"
    redirect_to users_path
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Wellcome to Alpha Blog #{@user.username}"
      
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
     @user = User.find(params[:id])
     if @user.update(user_params)
       flash[:success] = "User updated successfully"
       redirect_to articles_path
     else
       render 'edit'
     end
  end
  
  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(:page => params[:page], :per_page => 1)
  end
  
  private
  def user_params
    params.require(:user).permit(:username,:email,:password)
  end
  
  def admin_only
    if !logged_in? || !current_user.admin?
      flash[:danger] = "Only admin can perform this operation!!"
      redirect_to root_path
    end
    
  end
end