require 'test_helper'

class ManageConsoleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manage_console_index_url
    assert_response :success
  end

end
