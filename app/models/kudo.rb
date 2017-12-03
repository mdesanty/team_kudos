class Kudo < ApplicationRecord
  validates :message, length: {maximum: 255}

  belongs_to :from_slack_user, class_name: 'SlackUser'
  belongs_to :to_slack_user, class_name: 'SlackUser'
end