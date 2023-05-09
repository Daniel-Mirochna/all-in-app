class CoinGeckoApi < ApplicationController
  include HTTParty

  API_URL = "https://api.coingecko.com/api/v3/".freeze

  def self.ping
    HTTParty.get("#{API_URL}/ping")
  end

  def self.coins_list(vs_currency = "usd", order = "market_cap_desc", page = "1")
    params = { vs_currency:, order:, page: }
    HTTParty.get("#{API_URL}/coins/markets", query: params)
  end
end
