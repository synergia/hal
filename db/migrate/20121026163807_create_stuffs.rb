class CreateStuffs < ActiveRecord::Migration
  def change
    create_table :stuffs do |t|
      t.string :name
      t.integer :quantity
      t.integer :category_id

      t.timestamps
    end
  end
end
