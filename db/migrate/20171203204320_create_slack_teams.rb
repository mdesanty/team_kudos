class CreateSlackTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_teams do |t|
      t.string :slack_identifier
      t.timestamps
    end
  end
end
