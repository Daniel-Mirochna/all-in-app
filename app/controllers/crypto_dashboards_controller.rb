class CryptoDashboardsController < ApplicationController
  include HTTParty

  def index
    params = { ids: 'bitcoin', vs_currencies: 'usd' }

    response = HTTParty.get("https://api.coingecko.com/api/v3/simple/price", query: params )
    
    @data = response.body
  end
end
