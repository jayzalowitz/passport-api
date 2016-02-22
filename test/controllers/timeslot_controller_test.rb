require 'test_helper'

class TimeslotControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get book" do
    get :book
    assert_response :success
  end

end
