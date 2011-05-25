require 'test_helper'

class UserprojectsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Userproject.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Userproject.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to userproject_url(assigns(:userproject))
  end

  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Userproject.first
    assert_template 'show'
  end

  def test_destroy
    userproject = Userproject.first
    delete :destroy, :id => userproject
    assert_redirected_to userprojects_url
    assert !Userproject.exists?(userproject.id)
  end

  def test_update_invalid
    Userproject.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Userproject.first
    assert_template 'edit'
  end

  def test_update_valid
    Userproject.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Userproject.first
    assert_redirected_to userproject_url(assigns(:userproject))
  end

  def test_edit
    get :edit, :id => Userproject.first
    assert_template 'edit'
  end
end
