require 'rails_helper'

RSpec.describe Submission, type: :model do
  it { should belong_to(:school) }
end
