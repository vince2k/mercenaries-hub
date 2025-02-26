require "test_helper"

class MercenariesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mercenaries_new_url
    assert_response :success
  end
end
