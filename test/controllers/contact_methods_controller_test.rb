require 'test_helper'

class ContactMethodsControllerTest < ActionController::TestCase
  setup do
    @contact_method = contact_methods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_methods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_method" do
    assert_difference('ContactMethod.count') do
      post :create, contact_method: { name: @contact_method.name }
    end

    assert_redirected_to contact_method_path(assigns(:contact_method))
  end

  test "should show contact_method" do
    get :show, id: @contact_method
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact_method
    assert_response :success
  end

  test "should update contact_method" do
    patch :update, id: @contact_method, contact_method: { name: @contact_method.name }
    assert_redirected_to contact_method_path(assigns(:contact_method))
  end

  test "should destroy contact_method" do
    assert_difference('ContactMethod.count', -1) do
      delete :destroy, id: @contact_method
    end

    assert_redirected_to contact_methods_path
  end
end
