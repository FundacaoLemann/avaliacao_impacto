require 'rails_helper'

RSpec.describe CollectEntry, type: :model do
  it { is_expected.to belong_to(:collect) }
end
