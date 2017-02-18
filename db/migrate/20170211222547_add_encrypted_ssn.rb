class AddEncryptedSsn < ActiveRecord::Migration
  def change
    add_column :employees, :encrypted_ssn, :string
    add_column :employees, :encrypted_ssn_iv, :string
  end
end
