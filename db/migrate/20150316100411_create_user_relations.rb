class CreateUserRelations < ActiveRecord::Migration
  def change
    create_table :user_relations do |t|
      t.string :name
      t.string :sex
      t.integer :user_id

      t.timestamps
    end
  end
end
