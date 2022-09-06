class TradersController < ApplicationController
  before_action :authenticate_user!
  before_action :trader_access_restriction
  before_action :set_portfolio, except: [:transactions]

  def dashboard
    @transactions = current_user.transactions.includes(:stock).first(3)
  end

  def portfolio
    @properties = current_user.properties.includes(:stock)
  end

  def transactions
    @all_transactions = current_user.transactions.includes(:stock)
    @buy_transactions = current_user.transactions.buy.includes(:stock)
    @sell_transactions = current_user.transactions.sell.includes(:stock)
  end

  private 
  def set_portfolio
    @portfolio =  current_user.portfolio
    @portfolio.update(overall_worth: compute_overall_worth(current_user)) if @portfolio
  end
end
