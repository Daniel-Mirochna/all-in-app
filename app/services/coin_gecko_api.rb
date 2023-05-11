# API docs https://www.coingecko.com/en/api/documentation
class CoinGeckoApi
  include HTTParty

  URI = "https://api.coingecko.com/api/v3/".freeze

  def ping
    HTTParty.get("#{URI}/ping")
  end

  def coins_list(vs_currency = "usd", order = "market_cap_desc", page = "1")
    params = { vs_currency:, order:, page: }
    HTTParty.get("#{URI}/coins/markets", query: params)
  end

  def coin_info(id = "bitcoin")
    params = { localization: "false", tickers: false, developer_data: false, sparkline: false }
    HTTParty.get("#{URI}/coins/#{id}", query: params)
  end
end
