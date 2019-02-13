class CreateGroup < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
