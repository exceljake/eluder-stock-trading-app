module StockModule
  def retrieve_api_data(symbol)
    client = IEX::Api::Client.new
    begin
      quote = client.quote(symbol)
    rescue IEX::Errors::SymbolNotFoundError
      quote = nil
    end
    if quote
      company = client.company(symbol)
      logo = client.logo(symbol)
      stock_params = {
        symbol: quote.symbol,
        name: quote.company_name,
        latest_price: quote.latest_price,
        change_percent: quote.change_percent_s,
        exchange: company.exchange,
        sector: company.sector,
        industry: company.industry,
        description: company.description,
        logo: logo.url
      }
      @stock = Stock.create(stock_params)
      redirect_to stock_path(@stock)
    else
      flash.now[:alert] = "Stock symbol #{symbol} is not found"
      render :index, status: :not_found
    end
  end

  def fetch_update(stock)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex.sandbox[:publishable_token],
      secret_token: Rails.application.credentials.iex.sandbox[:secret_token],
      endpoint: Rails.application.credentials.iex.sandbox[:endpoint]
    )
    quote = client.quote(stock.symbol)
    stock_params = {
      latest_price: quote.latest_price,
      change_percent: quote.change_percent_s
    }
    stock.update(stock_params)
    stock
  end
end