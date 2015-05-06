class Chore < ActiveRecord::Base
  belongs_to :house
  has_many :issues, as: :issuable
  has_one :user_promise, as: :promisable
  has_many :chore_logs

  validates :task, presence: true
end
