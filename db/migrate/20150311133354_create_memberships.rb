class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :type
      t.float :fee_amount

      t.timestamps
    end
  end
end
