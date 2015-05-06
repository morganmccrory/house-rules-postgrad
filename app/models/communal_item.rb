class CommunalItem < ActiveRecord::Base
  belongs_to :house
  has_many :issues, as: :issuable
  has_one :user_promise, as: :promisable

  validates :name, presence: true
end
