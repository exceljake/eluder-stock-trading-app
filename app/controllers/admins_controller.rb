class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_access_restriction
  
  def dashboard
    @traders = User.traders
    @transactions = Transaction.all
  end

  def transactions
    @all_transactions = Transaction.all.includes(:stock)
    @buy_transactions = Transaction.buy.includes(:stock)
    @sell_transactions = Transaction.sell.includes(:stock)
  end
end
