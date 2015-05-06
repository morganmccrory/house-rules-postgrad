class Notification < ActiveRecord::Base

  has_many :user_notifications
  has_many :users, through: :user_notifications

end
