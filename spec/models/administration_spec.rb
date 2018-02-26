require 'rails_helper'

RSpec.describe Administration, type: :model do
  it { is_expected.to belong_to(:state) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to have_and_belong_to_many(:collects) }
end
