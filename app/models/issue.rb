class Issue < ActiveRecord::Base
  belongs_to :issuable, polymorphic: true
  belongs_to :user

  validates :reason, :length => { :minimum => 5 }
end
