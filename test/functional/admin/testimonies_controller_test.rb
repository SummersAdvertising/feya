require 'test_helper'

class Admin::TestimoniesControllerTest < ActionController::TestCase
  setup do
    @admin_testimony = admin_testimonies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_testimonies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_testimony" do
    assert_difference('Admin::Testimony.count') do
      post :create, admin_testimony: { article_id: @admin_testimony.article_id, cover: @admin_testimony.cover, status: @admin_testimony.status, title: @admin_testimony.title }
    end

    assert_redirected_to admin_testimony_path(assigns(:admin_testimony))
  end

  test "should show admin_testimony" do
    get :show, id: @admin_testimony
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_testimony
    assert_response :success
  end

  test "should update admin_testimony" do
    put :update, id: @admin_testimony, admin_testimony: { article_id: @admin_testimony.article_id, cover: @admin_testimony.cover, status: @admin_testimony.status, title: @admin_testimony.title }
    assert_redirected_to admin_testimony_path(assigns(:admin_testimony))
  end

  test "should destroy admin_testimony" do
    assert_difference('Admin::Testimony.count', -1) do
      delete :destroy, id: @admin_testimony
    end

    assert_redirected_to admin_testimonies_path
  end
end
