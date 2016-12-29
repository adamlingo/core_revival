class AddEffectiveDateToBenefitRate < ActiveRecord::Migration
  def change
    add_column :benefit_rates, :effective_date, :date
  end
end
