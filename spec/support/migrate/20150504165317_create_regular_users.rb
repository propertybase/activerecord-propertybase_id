class CreateRegularUsers < ActiveRecord::Migration
  def change
    create_table :regular_users do |t|
      t.string :email
      t.timestamps null: false

      t.references :regular_team
    end
  end
end
