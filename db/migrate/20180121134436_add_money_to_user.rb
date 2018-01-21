class AddMoneyToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :money, :float, :default => 0
  end
end
