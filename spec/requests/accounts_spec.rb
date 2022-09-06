require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  let!(:trader) { FactoryBot.create(:user, :skip_validate) }
  let!(:admin) { FactoryBot.create(:user, :skip_validate, :admin) }

  context "admin actions" do
    before do
      sign_in admin
    end

    it "updates user status to approved" do
      patch "/admin/accounts/#{trader.id}/approve"
      expect(flash[:notice]).to eq "Trader account has been approved"
      expect(response).to have_http_status(302)
    end
  end
end
