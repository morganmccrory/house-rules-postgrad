class Message < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :house

  has_one :picture

  def self.today
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  def self.yesterday
    where("DATE(created_at) = ?", Date.today-1)
  end
end
