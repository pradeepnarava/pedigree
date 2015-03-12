class RenameTokenInPayments < ActiveRecord::Migration
  def change
  	rename_column :payments, :token, :transaction_id
  end
end
