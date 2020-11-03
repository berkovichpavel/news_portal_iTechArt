require 'test_helper'

class PersonsControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get persons_profile_url
    assert_response :success
  end

end
