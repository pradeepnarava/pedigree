require 'test_helper'

class PatientControllerTest < ActionController::TestCase
  test "should get family_tree" do
    get :family_tree
    assert_response :success
  end

end
