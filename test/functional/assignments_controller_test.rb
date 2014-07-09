require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assignment" do
    assert_difference('Assignment.count') do
      post :create, :assignment => { }
    end

    assert_redirected_to assignment_path(assigns(:assignment))
  end

  test "should show assignment" do
    get :show, :id => assignments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => assignments(:one).to_param
    assert_response :success
  end

  test "should update assignment" do
    put :update, :id => assignments(:one).to_param, :assignment => { }
    assert_redirected_to assignment_path(assigns(:assignment))
  end

  test "should destroy assignment" do
    assert_difference('Assignment.count', -1) do
      delete :destroy, :id => assignments(:one).to_param
    end

    assert_redirected_to assignments_path
  end
end
