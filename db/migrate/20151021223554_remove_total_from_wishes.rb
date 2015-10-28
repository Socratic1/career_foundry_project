class RemoveTotalFromWishes < ActiveRecord::Migration
  def change
    remove_column :wishes, :total, :float
  end
end
