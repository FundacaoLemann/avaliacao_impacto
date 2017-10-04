require 'rails_helper'

RSpec.describe School, type: :model do
  it { should validate_uniqueness_of(:inep) }
end
