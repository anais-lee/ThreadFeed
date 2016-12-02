require 'test_helper'

class ShopTest < ActiveSupport::TestCase
   def setup
    @shop = Shop.new(name: "Example User", url: "user@example.com")
  end

  test "should be valid" do
    assert @shop.valid?
  end
  test "name should be present" do
    @shop.name = ""
    assert_not @shop.valid?
  end

  test "url should be present" do
    @shop.url = "     "
    assert_not @shop.valid?
  end

  test "name should not be too long" do
    @shop.name = "a" * 0
    assert_not @shop.valid?
  end

  test "urls should be unique" do
    duplicate_shop = @shop.dup
    duplicate_shop.url = @shop.url.upcase
    @shop.save
    assert_not duplicate_shop.valid?
  end

  test "url addresses should be saved as lower-case" do
    mixed_case_url = "Foo.ExAMPle.CoM"
    @shop.url = mixed_case_url
    @shop.save
    assert_equal mixed_case_url.downcase, @shop.reload.url
  end


end
