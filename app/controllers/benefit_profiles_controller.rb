class BenefitProfilesController < ApplicationController
  before_action :set_benefit_profile, only: [:show, :edit, :update, :destroy]

  # GET /benefit_profiles
  # GET /benefit_profiles.json
  def index
    @benefit_profiles = BenefitProfile.all
  end

  # GET /benefit_profiles/1
  # GET /benefit_profiles/1.json
  def show
  end

  # GET /benefit_profiles/new
  def new
    @benefit_profile = BenefitProfile.new
  end

  # GET /benefit_profiles/1/edit
  def edit
  end

  # POST /benefit_profiles
  # POST /benefit_profiles.json
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

  # PATCH/PUT /benefit_profiles/1
  # PATCH/PUT /benefit_profiles/1.json
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

  # DELETE /benefit_profiles/1
  # DELETE /benefit_profiles/1.json
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