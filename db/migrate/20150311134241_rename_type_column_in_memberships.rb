class RenameTypeColumnInMemberships < ActiveRecord::Migration
  def change
  	rename_column :memberships, :type, :name
  end
end
