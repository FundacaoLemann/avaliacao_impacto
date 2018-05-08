require "rails_helper"

RSpec.describe ActiveAdmin::ViewsHelper, type: :helper do
  describe ".calculate_submitted_percent" do
    it "returns the correct percentage for the given params" do
      expect(ActiveAdmin::ViewsHelper.calculate_submitted_percent(100, 10)).to eq("10.0%")
    end

    context "when any param is 0" do
      it "returns 0" do
        expect(ActiveAdmin::ViewsHelper.calculate_submitted_percent(0, 10)).to eq(0)
        expect(ActiveAdmin::ViewsHelper.calculate_submitted_percent(100, 0)).to eq(0)
      end
    end
  end

  describe ".i18n_for" do
    it "returns the correct term for the given params" do
      expect(ActiveAdmin::ViewsHelper.i18n_for("school", "inep")).to eq("INEP")
    end
  end
end
