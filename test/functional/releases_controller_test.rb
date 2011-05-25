require 'test_helper'

class ReleasesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Release.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Release.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to release_url(assigns(:release))
  end

  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Release.first
    assert_template 'show'
  end

  def test_destroy
    release = Release.first
    delete :destroy, :id => release
    assert_redirected_to releases_url
    assert !Release.exists?(release.id)
  end

  def test_update_invalid
    Release.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Release.first
    assert_template 'edit'
  end

  def test_update_valid
    Release.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Release.first
    assert_redirected_to release_url(assigns(:release))
  end

  def test_edit
    get :edit, :id => Release.first
    assert_template 'edit'
  end
end
