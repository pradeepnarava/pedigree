class RenameParentId < ActiveRecord::Migration
  def change
  	rename_column :users, :parent_id, :user_id
  end
end
