class CreateWishList < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|
      t.integer :user_id
      t.integer :product_id
      t.float :total
    end
    add_index :wish_lists, :user_id
    add_index :wish_lists, :product_id
  end
end
