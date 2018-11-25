require "test_helper"

class CategoriesListTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.create(:name => "Books")
    @category2 = Category.create(:name => "Sports")
  end
  
  test "check if listed are showing" do
    get categories_path
    assert_template "categories/index"
    assert_select("a[href=?]",category_path(@category), :text => @category.name)
    assert_select("a[href=?]",category_path(@category2), :text => @category2.name)
  end
end