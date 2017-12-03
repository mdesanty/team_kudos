class SlackUser < ApplicationRecord
  validates :email, length: {maximum: 255}
end