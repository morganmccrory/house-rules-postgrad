require 'rails_helper'

RSpec.describe Message, type: :model do
  message = FactoryGirl.build(:message)
  it { expect(message).to validate_length_of(:content)}
    # it { expect(message).to have_many(:issues)}

    it { expect(message).to belong_to(:housing_assignment)}
end
