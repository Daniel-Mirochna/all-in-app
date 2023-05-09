class CryptoDashboardsController < ApplicationController
  def index
    @data = CoinGeckoApi.coins_list
  end
end
