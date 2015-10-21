class RenameWishListToWish < ActiveRecord::Migration
  def change
  	rename_table :wish_lists, :wishs
  end
end
