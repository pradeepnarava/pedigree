class AddFatherMotherToUserRelations < ActiveRecord::Migration
  def change
    add_column :user_relations, :father_id, :integer, after: :sex
    add_column :user_relations, :mother_id, :integer, after: :father_id
  end
end
