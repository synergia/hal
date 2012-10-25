class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :project_id
      t.string :status
      t.text :comment

      t.timestamps
    end
  end
end
