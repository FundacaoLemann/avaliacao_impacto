require 'rails_helper'

RSpec.describe MecSchool, type: :model do
  it { should validate_uniqueness_of(:inep) }
end
