require 'rails_helper'

RSpec.describe Collect, type: :model do
  it { is_expected.to belong_to(:form) }
end
