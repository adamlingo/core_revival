class DropBenefitAccept < ActiveRecord::Migration
  def change
  	drop_table :benefit_accepts
  end
end
