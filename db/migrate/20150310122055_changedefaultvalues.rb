class Changedefaultvalues < ActiveRecord::Migration
  def change
  	change_column :users, :user_id, :integer, :default => 0
  	change_column :users, :role, :string, :default => "clinic"
  end
end
