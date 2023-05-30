class CryptocurrenciesController < ApplicationController
  before_action :set_currency

  def index; end

  def coins_list
    page = params[:page].to_i || 1
    @data = CoinGeckoApiService.coins_list(cookies[:currency], page)
  end

  def show
    @currency = cookies[:currency]
    @data = CoinGeckoApiService.coin_info(params[:coin_id])
  end

  private

  def set_currency
    return if Cryptocurrency::CURRENCY_SYMBOLS.include?(cookies[:currency])

    cookies[:currency] = { value: "usd", expires: Time.now + (3600 * 24 * 180) }
  end
end
