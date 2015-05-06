class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  validates :street, presence: true
  validates :city, presence: true
  validates :state, :format => /[a-zA-z]{2}/
  validates :zip_code, :length => { :minimum => 5 }
end
