class House < ActiveRecord::Base
  belongs_to :property_manager
  has_one :address, as: :addressable

  has_many :housing_assignments
  has_many :users, through: :housing_assignments
  has_many :rules
  has_many :events
  has_many :messages
  has_many :communal_items
  has_many :chores


  validates :name, presence: true
  validates :house_key, presence: true
end
