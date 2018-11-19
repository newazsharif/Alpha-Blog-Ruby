require "test_helper"

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.new(name: "Games")
    @category.save
  end
  
  test "check index route" do
    get :index
    assert_response :success
  end
  
  test "check new route" do
    get :new
    assert_response :success
  end
  
  test "check show route" do
    get(:show,{'id' => @category.id})
    assert_response :success
  end
  
end