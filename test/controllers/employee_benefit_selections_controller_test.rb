require "test_helper"

class EmployeeBenefitSelectionsControllerTest < ActionController::TestCase
  def employee_benefit_selection
    @employee_benefit_selection ||= employee_benefit_selections :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:employee_benefit_selections)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("EmployeeBenefitSelection.count") do
      post :create, employee_benefit_selection: { benefit_detail_id: employee_benefit_selection.benefit_detail_id, benefit_type: employee_benefit_selection.benefit_type, decline_benefit: employee_benefit_selection.decline_benefit, employee_id: employee_benefit_selection.employee_id }
    end

    assert_redirected_to employee_benefit_selection_path(assigns(:employee_benefit_selection))
  end

  def test_show
    get :show, id: employee_benefit_selection
    assert_response :success
  end

  def test_edit
    get :edit, id: employee_benefit_selection
    assert_response :success
  end

  def test_update
    put :update, id: employee_benefit_selection, employee_benefit_selection: { benefit_detail_id: employee_benefit_selection.benefit_detail_id, benefit_type: employee_benefit_selection.benefit_type, decline_benefit: employee_benefit_selection.decline_benefit, employee_id: employee_benefit_selection.employee_id }
    assert_redirected_to employee_benefit_selection_path(assigns(:employee_benefit_selection))
  end

  def test_destroy
    assert_difference("EmployeeBenefitSelection.count", -1) do
      delete :destroy, id: employee_benefit_selection
    end

    assert_redirected_to employee_benefit_selections_path
  end
end
