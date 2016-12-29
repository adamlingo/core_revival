require "test_helper"

class PayrollRecordsControllerTest < ActionController::TestCase
  def payroll_record
    @payroll_record ||= payroll_records :one
  end

  def test_index
    skip
    # get :index
    # assert_response :success
    # assert_not_nil assigns(:payroll_records)
  end

  def test_new
    skip
    # get :new
    # assert_response :success
  end

  def test_create
    skip
    # assert_difference("PayrollRecord.count") do
    #   post :create, payroll_record: {  }
    # end

    # assert_redirected_to payroll_record_path(assigns(:payroll_record))
  end

  def test_show
    skip
    # get :show, id: payroll_record
    # assert_response :success
  end

  def test_edit
    skip
    # get :edit, id: payroll_record
    # assert_response :success
  end

  def test_update
    skip
    # put :update, id: payroll_record, payroll_record: {  }
    # assert_redirected_to payroll_record_path(assigns(:payroll_record))
  end

  def test_destroy
    skip
    # assert_difference("PayrollRecord.count", -1) do
    #   delete :destroy, id: payroll_record
    # end

    # assert_redirected_to payroll_records_path
  end
end
