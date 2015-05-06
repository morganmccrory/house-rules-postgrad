require 'rails_helper'

RSpec.describe Address, type: :model do
  address = FactoryGirl.build(:address)
  it { expect(address).to validate_presence_of(:street) }
  it { expect(address).to validate_presence_of(:city) }
  it { expect(address).to allow_value('IL').for(:state) }
  it { expect(address).to validate_length_of(:password)}
  it { expect(address).to belong_to(:addressable)}
end
