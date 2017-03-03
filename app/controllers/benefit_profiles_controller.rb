class BenefitProfilesController < ApplicationController
  before_action :set_benefit_profile, only: [:show, :edit, :update, :destroy]
  # must be logged in
  before_filter :authenticate_user!
  before_filter :authorize_company!
  before_filter :authorize_manager!
  
  def index
    @benefit_profiles = BenefitProfile.where(company_id: current_user.company_id)
  end

  def show
    @benefit_profile = BenefitProfile.find(params[:id])
  end

  def new
    @benefit_profile = BenefitProfile.new
  end

  def edit
  end

  def create
    @benefit_profile = BenefitProfile.new(benefit_profile_params)

    respond_to do |format|
      if @benefit_profile.save
        format.html { redirect_to @benefit_profile, notice: 'Benefit profile was successfully created.' }
        format.json { render :show, status: :created, location: @benefit_profile }
      else
        format.html { render :new }
        format.json { render json: @benefit_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @benefit_profile.update(benefit_profile_params)
        format.html { redirect_to @benefit_profile, notice: 'Benefit profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @benefit_profile }
      else
        format.html { render :edit }
        format.json { render json: @benefit_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @benefit_profile.destroy
    respond_to do |format|
      format.html { redirect_to benefit_profiles_url, notice: 'Benefit profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_benefit_profile
      @benefit_profile = BenefitProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benefit_profile_params
      params.require(:benefit_profile).permit(:name, :company_id)
    end
end
