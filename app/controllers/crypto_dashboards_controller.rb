class CryptoDashboardsController < ApplicationController
  def index
    @data = CoinGeckoApi.new.coins_list
  end

  def show
    @data = CoinGeckoApi.new.coin_info(params[:coin_id])
  end
end
