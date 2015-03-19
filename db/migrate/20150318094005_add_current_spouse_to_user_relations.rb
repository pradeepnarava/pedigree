class AddCurrentSpouseToUserRelations < ActiveRecord::Migration
  def change
    add_column :user_relations, :current_spouse_id, :integer
  end
end
