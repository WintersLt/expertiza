require 'test_helper'


class VersionsControllerTest < ActionController::TestCase

  test 'should get index redirect to versions_search' do
    users(:user_one)
    get :index
    assert_redirected_to versions_search_path
  end

  test 'should delete destroy redirect to versions path' do
    delete :destroy, id: versions(:version_one).id
    assert_redirected_to versions_path
  end

  test 'should delete destroy_all redirect to versions path' do
    delete :destroy_all
    assert_redirected_to versions_path
  end



end