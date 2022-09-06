module ApplicationHelper
  def format_currency(num)
    number_to_currency(num, unit: "$")
  end

  def format_date(datetime)
    datetime.strftime("%l:%M %p,  %e %B %Y (%Z)")
  end

  def set_stock(stocks_arr, id)
    stock = stocks_arr.select {|stock| stock.id == id }
    stock[0]
  end

  def set_date(record)
    record.created_at.localtime.to_date
  end
end
