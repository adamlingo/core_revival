require "test_helper"

class BenefitProfilesControllerTest < ActionController::TestCase
  def benefit_profile
    @benefit_profile ||= benefit_profiles :one
  end

  def test_index
    skip
    # get :index
    # assert_response :success
    # assert_not_nil assigns(:benefit_profiles)
  end

  def test_new
    skip
    # get :new
    # assert_response :success
  end

  def test_create
    skip
    # assert_difference("BenefitProfile.count") do
    #   post :create, benefit_profile: { company_id: benefit_profile.company_id, name: benefit_profile.name }
    # end

    # assert_redirected_to benefit_profile_path(assigns(:benefit_profile))
  end

  def test_show
    skip
    # get :show, id: benefit_profile
    # assert_response :success
  end

  def test_edit
    skip
    # get :edit, id: benefit_profile
    # assert_response :success
  end

  def test_update
    skip
    # put :update, id: benefit_profile, benefit_profile: { company_id: benefit_profile.company_id, name: benefit_profile.name }
    # assert_redirected_to benefit_profile_path(assigns(:benefit_profile))
  end

  def test_destroy
    skip
    # assert_difference("BenefitProfile.count", -1) do
    #   delete :destroy, id: benefit_profile
    # end

    # assert_redirected_to benefit_profiles_path
  end
end
