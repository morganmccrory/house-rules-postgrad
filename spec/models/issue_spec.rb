require 'rails_helper'

RSpec.describe Issue, type: :model do
  issue = FactoryGirl.build(:rule_issue)
  it { expect(issue).to validate_length_of(:reason)}
    it { expect(issue).to belong_to(:user)}
    it { expect(issue).to belong_to(:issuable)}
end
