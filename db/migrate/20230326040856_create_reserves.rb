class CreateReserves < ActiveRecord::Migration[6.1]
  def change
    create_table :reserves do |t|
      t.integer :order_id, null: false
      t.integer :admin_id, null: false
      t.datetime :visit, null: false
      t.integer :total_payment, null: false
      t.boolean :visit_status, null: false, default: false
      t.text :cart_data, null: false
      t.timestamps
    end
  end
end
