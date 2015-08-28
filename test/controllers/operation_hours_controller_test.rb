require 'test_helper'

class OperationHoursControllerTest < ActionController::TestCase
  setup do
    @operation_hour = operation_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operation_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operation_hour" do
    assert_difference('OperationHour.count') do
      post :create, operation_hour: { name: @operation_hour.name }
    end

    assert_redirected_to operation_hour_path(assigns(:operation_hour))
  end

  test "should show operation_hour" do
    get :show, id: @operation_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operation_hour
    assert_response :success
  end

  test "should update operation_hour" do
    patch :update, id: @operation_hour, operation_hour: { name: @operation_hour.name }
    assert_redirected_to operation_hour_path(assigns(:operation_hour))
  end

  test "should destroy operation_hour" do
    assert_difference('OperationHour.count', -1) do
      delete :destroy, id: @operation_hour
    end

    assert_redirected_to operation_hours_path
  end
end
