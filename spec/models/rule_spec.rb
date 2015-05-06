require 'rails_helper'

RSpec.describe Rule, type: :model do
  rule = FactoryGirl.build(:rule)
  it { expect(rule).to validate_length_of(:content)}
  it { expect(rule).to have_many(:issues)}
  it { expect(rule).to belong_to(:housing_assignment)}
end
