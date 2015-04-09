class CreateCustomizedUsers < ActiveRecord::Migration
  def change
    create_table :customized_users, id: false do |t|
      t.propertybase_id :id, primary_key: true

      t.string :email
      t.timestamps null: false
    end
  end
end
