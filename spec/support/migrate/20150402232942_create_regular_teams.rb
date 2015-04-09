class CreateRegularTeams < ActiveRecord::Migration
  def change
    create_table :regular_teams do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
