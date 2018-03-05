require 'rails_helper'

RSpec.describe Notice, type: :model do
  it { is_expected.to validate_presence_of(:content) }
end
