require 'rails_helper'

RSpec.describe Form, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:link) }
end
