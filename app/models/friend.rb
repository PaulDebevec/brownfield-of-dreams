class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :user_friend, class_name: 'User'
end
