class FacebookAccount < ApplicationRecord
  belongs_to :user
  validates :facebook_user_id, :facebook_access_token, presence: true
end
