require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get dummy_database" do
    get :dummy_database
    assert_response :success
  end

end
