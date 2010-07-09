require 'test_helper'

class HrsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hrs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hr" do
    assert_difference('Hr.count') do
      post :create, :hr => { }
    end

    assert_redirected_to hr_path(assigns(:hr))
  end

  test "should show hr" do
    get :show, :id => hrs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hrs(:one).to_param
    assert_response :success
  end

  test "should update hr" do
    put :update, :id => hrs(:one).to_param, :hr => { }
    assert_redirected_to hr_path(assigns(:hr))
  end

  test "should destroy hr" do
    assert_difference('Hr.count', -1) do
      delete :destroy, :id => hrs(:one).to_param
    end

    assert_redirected_to hrs_path
  end
end
