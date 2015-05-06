class PropertyManager < ActiveRecord::Base
  has_one :address, as: :addressable
  has_many :houses

  validates :name, presence: true
end
