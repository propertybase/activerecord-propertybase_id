class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, id: false do |t|
      t.propertybase_id :id, primary_key: true

      t.string :name
      t.timestamps null: false
    end
  end
end
