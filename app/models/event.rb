class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :house
  has_many :issues, as: :issuable

  validates :title, presence: true
  validates :start, presence: true
  validates :end, presence: true
end