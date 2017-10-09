require 'rails_helper'

RSpec.describe City, type: :model do
  it { should belong_to(:state) }
end
