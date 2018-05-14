require "rails_helper"

RSpec.describe Contact, type: :model do
  it { is_expected.to belong_to(:collect) }
  it { is_expected.to belong_to(:school) }
end
