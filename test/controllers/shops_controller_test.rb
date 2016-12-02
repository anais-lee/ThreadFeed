require 'test_helper'

class ShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get shops_new_url
    assert_response :success
  end

end
