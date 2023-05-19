# API docs https://www.coingecko.com/en/api/documentation
module CoinGeckoApiService
  include HTTParty

  URI = "https://api.coingecko.com/api/v3/".freeze

  def self.ping
    HTTParty.get("#{URI}/ping")
  end

  def self.coins_list(vs_currency = "usd", page = "1", order = "market_cap_desc")
    params = { vs_currency:, page:, order: }
    HTTParty.get("#{URI}/coins/markets", query: params)
  end

  def self.coin_info(id = "bitcoin")
    params = { localization: "false", tickers: false, developer_data: false, sparkline: false }
    HTTParty.get("#{URI}/coins/#{id}", query: params)
  end
end
