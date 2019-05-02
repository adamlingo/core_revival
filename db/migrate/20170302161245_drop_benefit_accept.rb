class DropBenefitAccept < ActiveRecord::Migration
  def change
  	table_exists?(:benefit_accept) ? drop_table(:benefit_accept) : nil
  end
end
