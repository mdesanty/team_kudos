class AddFieldsToSlackUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :slack_users, :slack_team_id, :integer
    add_column :slack_users, :slack_identifier, :string
  end
end
