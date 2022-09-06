require 'rails_helper'

RSpec.describe "Properties", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/properties/show"
      expect(response).to have_http_status(:success)
    end
  end

end
