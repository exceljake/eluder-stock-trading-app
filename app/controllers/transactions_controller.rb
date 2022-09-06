class TransactionsController < ApplicationController
  include TransactionModule
  before_action :trader_access_restriction, except: [:admin_show]
  before_action :admin_access_restriction, only: [:admin_show]
  before_action :setup_transaction, only: [:buy,:sell]

  def trader_show 
    @transaction = Transaction.find(params[:id])
  end

  def admin_show
    @transaction = Transaction.find(params[:id])
  end

  def buy
    quantity = params[:buy].to_d
    cost = @stock.latest_price * quantity
    if check_permit(@stock, @trader.status, @portfolio) && check_balance(@stock, @trader.balance, cost)
      @property = @trader.properties.find_by(stock_id: @stock.id)
      buy_requirements = {
        trader: @trader,
        portfolio: @portfolio,
        property: @property,
        stock: @stock,
        quantity: quantity,
        cost: cost
      }
      buy_stock(buy_requirements)
    end
  end

  def sell
    quantity = params[:sell].to_d
    cost = @stock.latest_price * quantity
    if check_permit(@stock, @trader.status, @portfolio)
      @property = @trader.properties.find_by(stock_id: @stock.id)
      if check_ownership(@stock, @property) && check_quantity(@stock, @property.quantity, quantity)
        sell_requirements = {
          trader: @trader,
          portfolio: @portfolio,
          property: @property,
          stock: @stock,
          quantity: quantity,
          cost: cost
        }
        sell_stock(sell_requirements)
      end
    end
  end

  
  private
  def setup_transaction
    @stock = Stock.find(params[:id])
    @trader = current_user
    @portfolio = Portfolio.find_by(user_id: @trader.id)
  end
end
