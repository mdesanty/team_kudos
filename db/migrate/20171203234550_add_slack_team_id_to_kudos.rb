class AddSlackTeamIdToKudos < ActiveRecord::Migration[5.1]
  def change
    add_column :kudos, :slack_team_id, :integer
  end
end
