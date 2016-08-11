class AddTimestampToReconciliation < ActiveRecord::Migration
  def change
    add_column :reconciliations, :created_at, :datetime
    add_column :reconciliations, :updated_at, :datetime
  end
end
