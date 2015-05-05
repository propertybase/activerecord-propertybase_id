class CreateRegularListings < ActiveRecord::Migration
  def change
    create_table :regular_listings do |t|
      t.string :address
      t.timestamps null: false
    end

    add_reference :regular_listings, :regular_user
  end
end
