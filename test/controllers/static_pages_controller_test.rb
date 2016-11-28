require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  	
  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "ThreadFeed"
  end

  test "should get home" do
    get home_path
    assert_response :success
    assert_select "title", "ThreadFeed"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | ThreadFeed"
  end

  test "should get about" do
  	get about_path
  	assert_response :success
  	assert_select "title", "About | ThreadFeed"
  end

  test "should get contact" do 
  	get contact_path
  	assert_response :success
  	assert_select "title", "Contact | ThreadFeed"
  end

end
