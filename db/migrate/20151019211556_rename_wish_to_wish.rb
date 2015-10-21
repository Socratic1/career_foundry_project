class RenameWishToWish < ActiveRecord::Migration
  def change
  	rename_table :wishs, :wishes
  end
end
