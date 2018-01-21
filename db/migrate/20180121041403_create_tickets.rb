class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.integer :places
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
