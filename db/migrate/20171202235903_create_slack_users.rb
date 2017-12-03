class CreateSlackUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_users do |t|
      t.string :email
      t.references :slack_user
      t.timestamps
    end
  end
end
