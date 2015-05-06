require 'rails_helper'

RSpec.describe CommunalItem, type: :model do
  communal_item = FactoryGirl.build(:communal_item)
  it { expect(communal_item).to validate_presence_of(:name)}
    it { expect(communal_item).to belong_to(:house)}
    it { expect(communal_item).to have_many(:issues)}
    it { expect(communal_item).to have_many(:user_promises)}
end
