require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(:username => "john", :email => "john_doe@gmail.com", :password => "12345", :admin => true )
  end
  test "create new category form and save" do
    sign_in_as(@user,"12345")
    get new_category_path
    assert_template 'categories/new'
    
    assert_difference 'Category.count',1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    
    assert_template "categories/index"
    assert_match "sports", response.body
  end
  
  
  test "test new category failure" do
    sign_in_as(@user,"12345")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference  "Category.count" do
      post categories_path,:category => {:name => " "}
    end
    assert_template "categories/new"
    assert_select "div.panel-title"
    assert_select "div.panel-body"
  end
end