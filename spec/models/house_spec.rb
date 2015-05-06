require 'rails_helper'

RSpec.describe House, type: :model do
  house = FactoryGirl.build(:house)

  it { expect(house).to have_one(:address)}
  it { expect(house).to belong_to(:property_manager)}
  it { expect(house).to have_many(:messages)}
  it { expect(house).to have_many(:users)}
  it { expect(house).to have_many(:communal_items)}
  it { expect(house).to have_many(:rules)}
  it { expect(house).to have_many(:chores)}
  it { expect(house).to have_many(:events)}
  it { expect(house).to validate_presence_of(:name)}

end
