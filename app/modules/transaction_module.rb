module TransactionModule
  def check_permit(stock, status, portfolio)
    if status == "approved" && portfolio
      true
    else
      msg = ""
      msg += "Your account has not yet been approved for trading. " if status != "approved"
      msg += "You have yet to setup your portfolio." if !portfolio
      flash[:alert] = msg 
      redirect_to stock_path(stock) and return
    end
  end

  def check_balance(stock, balance, cost)
    if balance >= cost
      true
    else
      flash[:alert] = "You have insufficient funds to buy this stock"
      redirect_to stock_path(stock) and return
    end
  end

  def check_ownership(stock, property)
    if property
      true
    else
      flash[:alert] = "You do not own this stock"
      redirect_to stock_path(stock) and return
    end
  end

  def check_quantity(stock, owned, quantity)
    if owned >= quantity
      true
    else
      flash[:alert] = "You do not own enough stocks"
      redirect_to stock_path(stock) and return
    end
  end

  def buy_stock(hash)
    # Destructure contents of hash
    trader = hash[:trader]
    portfolio = hash[:portfolio]
    property = hash[:property]
    stock = hash[:stock]
    quantity = hash[:quantity]
    cost = hash[:cost]

    transaction_params = { 
      stock_id: stock.id, 
      action: "buy", 
      quantity: quantity, 
      price: stock.latest_price,
      total_amount: cost
    }
    new_transaction = trader.transactions.create(transaction_params)
    trader.update(balance: trader.balance - cost)
    if property # Property is present in trader portfolio
      property_params = {
        quantity: property.quantity + quantity
      }
      property.update(property_params)
    else # Property is not present in trader portfolio
      property_params = { 
        stock_id: stock.id, 
        quantity: quantity
      }
      new_property = portfolio.properties.create(property_params)
    end
    redirect_to trader_transaction_path(new_transaction)
  end


  def sell_stock(hash)
    # Destructure contents of hash
    trader = hash[:trader]
    portfolio = hash[:portfolio]
    property = hash[:property]
    stock = hash[:stock]
    quantity = hash[:quantity]
    cost = hash[:cost]

    transaction_params = { 
      stock_id: stock.id, 
      action: "sell", 
      quantity: quantity, 
      price: stock.latest_price,
      total_amount: cost
    }
    new_transaction = trader.transactions.create(transaction_params)
    trader.update(balance: trader.balance + cost)
    property_params = {
      quantity: property.quantity - quantity
    }
    property.update(property_params)
    redirect_to trader_transaction_path(new_transaction)
  end
end

