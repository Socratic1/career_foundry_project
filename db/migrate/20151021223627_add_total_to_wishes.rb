class AddTotalToWishes < ActiveRecord::Migration
  def change
  	add_column :wishes, :total, :integer
  end
end
