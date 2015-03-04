class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :token
      t.string :payer_id
      t.float :amount

      t.timestamps
    end
  end
end
