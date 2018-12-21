require 'test_helper'

class CaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @care = cares(:one)
  end

  test "should get index" do
    get cares_url
    assert_response :success
  end

  test "should get new" do
    get new_care_url
    assert_response :success
  end

  test "should create care" do
    assert_difference('Care.count') do
      post cares_url, params: { care: { fed: @care.fed, medicated: @care.medicated } }
    end

    assert_redirected_to care_url(Care.last)
  end

  test "should show care" do
    get care_url(@care)
    assert_response :success
  end

  test "should get edit" do
    get edit_care_url(@care)
    assert_response :success
  end

  test "should update care" do
    patch care_url(@care), params: { care: { fed: @care.fed, medicated: @care.medicated } }
    assert_redirected_to care_url(@care)
  end

  test "should destroy care" do
    assert_difference('Care.count', -1) do
      delete care_url(@care)
    end

    assert_redirected_to cares_url
  end
end
