class CategoriesController < ApplicationController
  
  before_action :require_admin, :except => [:index,:show]
  before_action :set_category , only: [:edit,:update,:show,:destroy]
  
  def index
    @categories = Category.paginate(:page => params[:page], :per_page => 5)
  end
  
  def new
    @category = Category.new
  end
  
  
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(:page => params[:page], :per_page => 5)
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created successgully"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def edit
   
    
  end
  
  
  def update
    
    if @category.update(category_params)
      flash[:success] = "Category Updated Successfully"
      redirect_to edit_category_path(@category)
    else
      redirect_to root_path
    end
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    if(!logged_in? || (logged_in? && !current_user.admin?))
      flash[:danger] = "only admin can perform this action"
      redirect_to categories_path
    end
  end
  
  def set_category
     @category = Category.find(params[:id])
  end
end