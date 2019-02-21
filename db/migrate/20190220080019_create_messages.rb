class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :user_id
      t.integer :post_id

      t.index :post_id
      t.index :user_id
      t.timestamps null: false
    end
  end
end
