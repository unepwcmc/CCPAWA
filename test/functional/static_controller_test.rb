require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get information" do
    get :information
    assert_response :success
  end

  test "should get data_and_tools" do
    get :data_and_tools
    assert_response :success
  end

  test "should get people" do
    get :people
    assert_response :success
  end

end
