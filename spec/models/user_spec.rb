require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { FactoryBot.create(:user) }
    it { is_expected.to validate_presence_of(:sub) }
    it { is_expected.to validate_uniqueness_of(:sub) }
  end

  describe 'resource_id' do
    subject { FactoryBot.create(:user) }
    it 'sets a resource_id on model creation' do
      expect(subject.resource_id).to_not be_nil
      expect(subject.resource_id).to include 'USR'
    end
  end
end
