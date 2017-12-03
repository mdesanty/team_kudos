class CreateKudos < ActiveRecord::Migration[5.1]
  def change
    create_table :kudos do |t|
      t.string :message
      t.references :from_slack_user
      t.references :to_slack_user
      t.timestamps
    end
  end
end
