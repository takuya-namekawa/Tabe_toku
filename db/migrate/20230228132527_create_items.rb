class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.integer :admin_id
      t.string :name
      t.text :explanation
      t.integer :half_price
      t.integer :price
      t.integer :inventory
      t.boolean :is_ordered, null: false, default: true

      t.timestamps
    end
  end
end
