# Initialize Admin Account
admin_account = {
  first_name: "Admin",
  last_name: "Eluder",
  email: "admin@eluder.com",
  password: "eluder2022",
  role: "admin"
}
User.create(admin_account)

# Seed Stock Model
client = IEX::Api::Client.new
top10 = client.stock_market_list(:mostactive)

top10.each do |stock|
  company = client.company(stock.symbol)
  logo = client.logo(stock.symbol)
  stock_params = {
    symbol: stock.symbol,
    name: stock.company_name,
    latest_price: stock.latest_price,
    change_percent: stock.change_percent_s,
    exchange: company.exchange,
    sector: company.sector,
    industry: company.industry,
    description: company.description,
    logo: logo.url
  }
  Stock.create(stock_params)
end
