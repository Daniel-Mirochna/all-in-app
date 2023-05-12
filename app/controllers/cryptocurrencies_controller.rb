class CryptocurrenciesController < ApplicationController
  before_action :set_currency

  def index; end

  def coins_list
    @data = CoinGeckoApiService.coins_list
  end

  def show
    @data = CoinGeckoApiService.coin_info(params[:coin_id])
  end

  private

  def set_currency
    cookies[:currency] = { value: "usd", expires: Time.now + 3600 * 24 * 180} unless Cryptocurrency::CURRENCY_SYMBOLS.include?(cookies[:currency])
  end
end
