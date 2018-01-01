class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.float :price
      t.date :event_date
      t.integer :size
      t.boolean :for_children
      t.string :image

      t.timestamps
    end
  end
end
