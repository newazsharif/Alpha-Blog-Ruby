require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  
  def setup
    @category = Category.new(name: "sports")
  end
  
  test "category should be valid" do
    assert @category.valid?
  end
  
  test "name must be given" do
    @category.name = " "
    assert_not @category.valid?
  end
  
  test "name must be unique" do
    @category.save
    category2 = Category.new(:name => "sports")
    assert_not category2.valid?
  end
  
  test "name must not be too long" do
    @category.name = "a"*28
    assert_not @category.valid?
  end
  
  test "name must not be short" do
    @category.name = "a"*3
    assert_not @category.valid?
  end
  
end