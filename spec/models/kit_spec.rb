require 'rails_helper'

RSpec.describe Kit, type: :model do
  it { is_expected.to belong_to(:manufacturer) }
end
