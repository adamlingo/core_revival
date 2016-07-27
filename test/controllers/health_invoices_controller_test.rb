require "test_helper"

class HealthInvoicesControllerTest < ActionController::TestCase
  def health_invoice
    @health_invoice ||= health_invoices :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:health_invoices)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("HealthInvoice.count") do
      post :create, health_invoice: {  }
    end

    assert_redirected_to health_invoice_path(assigns(:health_invoice))
  end

  def test_show
    get :show, id: health_invoice
    assert_response :success
  end

  def test_edit
    get :edit, id: health_invoice
    assert_response :success
  end

  def test_update
    put :update, id: health_invoice, health_invoice: {  }
    assert_redirected_to health_invoice_path(assigns(:health_invoice))
  end

  def test_destroy
    assert_difference("HealthInvoice.count", -1) do
      delete :destroy, id: health_invoice
    end

    assert_redirected_to health_invoices_path
  end
end
