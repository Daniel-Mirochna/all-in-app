# API docs https://www.coingecko.com/en/api/documentation
module CoinGeckoApiService
  include HTTParty

  URI = "https://api.coingecko.com/api/v3/".freeze

  def self.ping
    HTTParty.get("#{URI}/ping")
  end

  def self.coins_list(vs_currency = "usd", page = "1", order = "market_cap_desc")
    params = { vs_currency:, page:, order: }
    Rails.cache.fetch([:coins_list, vs_currency, page], expires_in: 15.minutes) do
      HTTParty.get("#{URI}/coins/markets", query: params)
    end
  end

  def self.coin_info(id = "bitcoin")
    params = { localization: "false", tickers: false, developer_data: false, sparkline: false }
    Rails.cache.fetch([:coin_info, id], expires_in: 15.minutes) do
      HTTParty.get("#{URI}/coins/#{id}", query: params)
    end
  end
end
