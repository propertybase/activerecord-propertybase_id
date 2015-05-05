class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.propertybase_id :id, primary_key: true
      t.references :team, type: :propertybase_id

      t.string :email
      t.timestamps null: false
    end
  end
end
