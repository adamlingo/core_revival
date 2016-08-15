require "test_helper"

class ReconciliationsControllerTest < ActionController::TestCase
  def reconciliation
    @reconciliation ||= reconciliations :one
  end

  def test_index
    # get :index
    # assert_response :success
    # assert_not_nil assigns(:reconciliations)
  end

  def test_new
    # get :new
    # assert_response :success
  end

  def test_create
    # assert_difference("Reconciliation.count") do
    #   post :create, reconciliation: {  }
    # end

    # assert_redirected_to reconciliation_path(assigns(:reconciliation))
  end

  def test_show
    # get :show, id: reconciliation
    # assert_response :success
  end

  def test_edit
    # get :edit, id: reconciliation
    # assert_response :success
  end

  def test_update
    # put :update, id: reconciliation, reconciliation: {  }
    # assert_redirected_to reconciliation_path(assigns(:reconciliation))
  end

  def test_destroy
    # assert_difference("Reconciliation.count", -1) do
    #   delete :destroy, id: reconciliation
    # end

    # assert_redirected_to reconciliations_path
  end
end
