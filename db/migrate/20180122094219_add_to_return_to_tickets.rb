class AddToReturnToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :to_return, :boolean, :default => false
  end
end
