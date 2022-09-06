class StocksController < ApplicationController
  include StockModule
  before_action :authenticate_user!
  before_action :all_stocks, only: [:index, :check]
  before_action :set_stock, only: [:show]

  def index
  end

  def show
    @portfolio = current_user.portfolio
    @property = current_user.properties.where(stock_id: @stock.id).first
    @transactions = current_user.transactions.where(stock_id: @stock.id).first(3)
    @recent_transactions = @stock.transactions.first(3)
  end

  def check
    search_symbol = params[:search].gsub(/\s+/, "").upcase
    @result = Stock.find_by(symbol: search_symbol)
    if @result
      redirect_to stock_path(@result)
    else
      retrieve_api_data(search_symbol)
    end
  end

  private
  def all_stocks
    @stocks = Stock.all
  end
  
  def set_stock
    stock = Stock.find(params[:id])
    @stock = fetch_update(stock)
  end
end
