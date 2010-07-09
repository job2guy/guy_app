require 'test_helper'

class MemberDetailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_detail" do
    assert_difference('MemberDetail.count') do
      post :create, :member_detail => { }
    end

    assert_redirected_to member_detail_path(assigns(:member_detail))
  end

  test "should show member_detail" do
    get :show, :id => member_details(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => member_details(:one).to_param
    assert_response :success
  end

  test "should update member_detail" do
    put :update, :id => member_details(:one).to_param, :member_detail => { }
    assert_redirected_to member_detail_path(assigns(:member_detail))
  end

  test "should destroy member_detail" do
    assert_difference('MemberDetail.count', -1) do
      delete :destroy, :id => member_details(:one).to_param
    end

    assert_redirected_to member_details_path
  end
end
