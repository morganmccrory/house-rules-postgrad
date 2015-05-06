require 'rails_helper'

RSpec.describe UserPromise, type: :model do
  user_promise = FactoryGirl.build(:chore_promise)
    it { expect(user_promise).to belong_to(:user)}
    # it { expect(user_promise).to have_many(:promisable)}
end
