class Rule < ActiveRecord::Base
  belongs_to :house
  has_many :issues, as: :issuable

  validates :content,  :length => { :minimum => 6 }
end
