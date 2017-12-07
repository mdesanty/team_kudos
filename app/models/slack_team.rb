class SlackTeam < ApplicationRecord
  has_many :slack_users
end