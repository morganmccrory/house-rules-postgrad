require 'rails_helper'

RSpec.describe PropertyManager, type: :model do
  manager = FactoryGirl.build(:property_manager)
  it { expect(manager).to validate_presence_of(:name) }
  it { expect(manager).to have_one(:address)}
  it { expect(manager).to have_many(:houses)}
end
