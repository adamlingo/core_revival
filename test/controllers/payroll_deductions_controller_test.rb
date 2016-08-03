require "test_helper"

class PayrollDeductionsControllerTest < ActionController::TestCase
  def payroll_deduction
    @payroll_deduction ||= payroll_deductions :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:payroll_deductions)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("PayrollDeduction.count") do
      post :create, payroll_deduction: {  }
    end

    assert_redirected_to payroll_deduction_path(assigns(:payroll_deduction))
  end

  def test_show
    get :show, id: payroll_deduction
    assert_response :success
  end

  def test_edit
    get :edit, id: payroll_deduction
    assert_response :success
  end

  def test_update
    put :update, id: payroll_deduction, payroll_deduction: {  }
    assert_redirected_to payroll_deduction_path(assigns(:payroll_deduction))
  end

  def test_destroy
    assert_difference("PayrollDeduction.count", -1) do
      delete :destroy, id: payroll_deduction
    end

    assert_redirected_to payroll_deductions_path
  end
end
