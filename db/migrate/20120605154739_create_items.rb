class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :category_id
      t.string :name
      t.string :code
      t.string :state
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
