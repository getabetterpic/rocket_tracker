require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  subject { create(:manufacturer) }

  it { is_expected.to have_many(:motors) }
  it { is_expected.to have_many(:kits) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
end
