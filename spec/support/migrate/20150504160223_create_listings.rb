class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings, id: false do |t|
      t.propertybase_id :id, primary_key: true

      t.string :address
      t.timestamps null: false
    end

    add_reference :listings, :user, type: :propertybase_id
  end
end
