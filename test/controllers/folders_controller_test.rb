require "test_helper"

class FoldersControllerTest < ActionController::TestCase
  def folder
    @folder ||= folders :one
  end

  # def test_index
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:folders)
  # end

  # def test_new
  #   get :new
  #   assert_response :success
  # end

  # def test_create
  #   assert_difference("Folder.count") do
  #     post :create, folder: {  }
  #   end

  #   assert_redirected_to folder_path(assigns(:folder))
  # end

  # def test_show
  #   get :show, id: folder
  #   assert_response :success
  # end

  # def test_edit
  #   get :edit, id: folder
  #   assert_response :success
  # end

  # def test_update
  #   put :update, id: folder, folder: {  }
  #   assert_redirected_to folder_path(assigns(:folder))
  # end

  # def test_destroy
  #   assert_difference("Folder.count", -1) do
  #     delete :destroy, id: folder
  #   end

  #   assert_redirected_to folders_path
  # end
end
