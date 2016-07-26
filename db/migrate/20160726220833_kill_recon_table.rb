class KillReconTable < ActiveRecord::Migration
  def change
    drop_table :recons
  end
end
