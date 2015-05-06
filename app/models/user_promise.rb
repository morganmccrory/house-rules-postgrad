class UserPromise < ActiveRecord::Base
  belongs_to :user
  belongs_to :promisable, polymorphic: true
end
