class PortfolioController < ApplicationController
  before_action :trader_access_restriction

  def create 
    current_user.create_portfolio(overall_worth: 0)
    flash[:notice] = "Trader Portfolio has been setup successfully"
    redirect_to trader_portfolio_path
  end 
end

