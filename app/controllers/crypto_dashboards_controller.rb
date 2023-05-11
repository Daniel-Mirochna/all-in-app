class CryptoDashboardsController < ApplicationController
  def index
    @data = CoinGeckoApiService.coins_list
  end

  def show
    @data = CoinGeckoApiService.coin_info(params[:coin_id])
  end
end
