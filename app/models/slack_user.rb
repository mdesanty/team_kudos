class SlackUser < ApplicationRecord
  belongs_to :slack_team

  validates :email, length: {maximum: 255}
end