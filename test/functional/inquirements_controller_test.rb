require 'test_helper'

class InquirementsControllerTest < ActionController::TestCase
  setup do
    @inquirement = inquirements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inquirements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inquirement" do
    assert_difference('Inquirement.count') do
      post :create, inquirement: { course_id: @inquirement.course_id, description: @inquirement.description, email: @inquirement.email, name: @inquirement.name, phone: @inquirement.phone }
    end

    assert_redirected_to inquirement_path(assigns(:inquirement))
  end

  test "should show inquirement" do
    get :show, id: @inquirement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inquirement
    assert_response :success
  end

  test "should update inquirement" do
    put :update, id: @inquirement, inquirement: { course_id: @inquirement.course_id, description: @inquirement.description, email: @inquirement.email, name: @inquirement.name, phone: @inquirement.phone }
    assert_redirected_to inquirement_path(assigns(:inquirement))
  end

  test "should destroy inquirement" do
    assert_difference('Inquirement.count', -1) do
      delete :destroy, id: @inquirement
    end

    assert_redirected_to inquirements_path
  end
end
