require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
    	@user = users(:angela)
    	@other_user = users(:archer)
  	end

  	test "login with invalid information" do
		get login_path
		assert_template 'sessions/new'
		post login_path, params: { session: { email: "", password: "" } }
		assert_template 'sessions/new'
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end

	test "login with valid information followed by logout" do
	    get login_path
	    post login_path, params: { session: { email:    @user.email,
	                                          password: 'password' } }
	    assert is_logged_in?
	    assert_redirected_to @user
	    follow_redirect!
	    assert_template 'users/show'
	    assert_select "a[href=?]", login_path, count: 0
	    assert_select "a[href=?]", logout_path
	    assert_select "a[href=?]", user_path(@user)
	    delete logout_path
	    assert_not is_logged_in?
	    assert_redirected_to root_url
	    # Simulate a user clicking logout in a second window.
	    delete logout_path
	    follow_redirect!
	    assert_select "a[href=?]", login_path
	    assert_select "a[href=?]", logout_path,      count: 0
	    assert_select "a[href=?]", user_path(@user), count: 0
	  end

	test "should redirect edit when logged in as wrong user" do
	    log_in_as(@other_user)
	    get edit_user_path(@user)
	    assert flash.empty?
	    assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
	    log_in_as(@other_user)
	    patch user_path(@user), params: { user: { name: @user.name,
	                                              email: @user.email } }
	    assert flash.empty?
	    assert_redirected_to root_url
	end

	test "successful edit with friendly forwarding" do
	    get edit_user_path(@user)
	    log_in_as(@user)
	    assert_redirected_to edit_user_url(@user)
	    name  = "Foo Bar"
	    email = "foo@bar.com"
	    patch user_path(@user), params: { user: { name:  name,
	                                              email: email,
	                                              password:              "",
	                                              password_confirmation: "" } }
	    assert_not flash.empty?
	    assert_redirected_to @user
	    @user.reload
	    assert_equal name,  @user.name
	    assert_equal email, @user.email
	end
end
