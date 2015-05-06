require 'rails_helper'

RSpec.describe ChoreLog, type: :model do
  chore_log = FactoryGirl.build(:chore_log)
    it { expect(chore_log).to belong_to(:user)}
    it { expect(chore_log).to belong_to(:chore)}
end
