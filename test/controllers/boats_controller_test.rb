require 'test_helper'

class BoatsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get assign" do
    get :assign
    assert_response :success
  end

end