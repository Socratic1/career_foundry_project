class AddAmountToProduct < ActiveRecord::Migration
  def change
    add_column :products, :amount, :integer
  end
end
