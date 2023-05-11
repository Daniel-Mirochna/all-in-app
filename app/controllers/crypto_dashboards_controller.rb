class CryptoDashboardsController < ApplicationController
  def index
    @data = CoinGeckoApi.coins_list
  end

  def show
    @data = CoinGeckoApi.coin_info(params[:coin_id])
  end
end
