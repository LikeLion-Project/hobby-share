require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get navigation" do
    get :navigation
    assert_response :success
  end

end
