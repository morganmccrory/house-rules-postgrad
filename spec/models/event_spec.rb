require 'rails_helper'

RSpec.describe Event, type: :model do
  event = FactoryGirl.build(:event)
  it { expect(event).to validate_presence_of(:name)}
  it { expect(event).to validate_presence_of(:date)}
  it { expect(event).to belong_to(:housing_assignment)}
  it { expect(event).to have_many(:issues)}

end
