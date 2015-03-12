require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get membership" do
    get :membership
    assert_response :success
  end

end
