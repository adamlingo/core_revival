require "test_helper"

class EmployeesControllerTest < ActionController::TestCase
  def employee
    @employee ||= employees :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:employees)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Employee.count") do
      post :create, employee: { company_id: employee.company_id, name: employee.name }
    end

    assert_redirected_to employee_path(assigns(:employee))
  end

  def test_show
    get :show, id: employee
    assert_response :success
  end

  def test_edit
    get :edit, id: employee
    assert_response :success
  end

  def test_update
    put :update, id: employee, employee: { company_id: employee.company_id, name: employee.name }
    assert_redirected_to employee_path(assigns(:employee))
  end

  def test_destroy
    assert_difference("Employee.count", -1) do
      delete :destroy, id: employee
    end

    assert_redirected_to employees_path
  end
end
