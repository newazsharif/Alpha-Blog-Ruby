require "test_helper"

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    
    @category = Category.new(name: "Games")
    @category.save
    @user = User.create(:username => "john", :email => "john_doe@gmail.com", :password => "12345", :admin => true )
    
  end
  
  test "check index route" do
    get :index
    assert_response :success
  end
  
  test "check new route" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end
  
  test "check show route" do
    get(:show,{'id' => @category.id})
    assert_response :success
  end
  
  test "prevent create without admin permission" do
    # session[:user_id] = @user.id
    assert_no_difference 'Category.count' do
      post(:create,:category => {:name => "Sports"})
    end
    assert_redirected_to categories_path
  end
end