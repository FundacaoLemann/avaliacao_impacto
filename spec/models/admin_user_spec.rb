require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe "#sub_admin" do
    subject { user.sub_admin? }

    context "when user is admin" do
      let(:user) { build(:admin_user, :admin) }
      it { is_expected.to be_truthy }
    end

    context "when user is service_manager" do
      let(:user) { build(:admin_user, :service_manager) }
      it { is_expected.to be_truthy }
    end

    context "when user is service_analyst" do
      let(:user) { build(:admin_user, :service_analyst) }
      it { is_expected.to be_falsey }
    end

    context "when user is lemann" do
      let(:user) { build(:admin_user, :lemann) }
      it { is_expected.to be_falsey }
    end
  end
end
