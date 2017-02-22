class ChangeBenefitAcceptsColumn < ActiveRecord::Migration
  def change
  	change_column_null :benefit_accepts, :accept, false
  end
end
