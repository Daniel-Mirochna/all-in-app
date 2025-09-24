module CoinGeckoSdk
  module Resources
    class Coins < BaseResource
      def self.markets(vs_currency: "usd", page: 1, order: "market_cap_desc", **options)
        params = {
          vs_currency: vs_currency,
          page: page,
          order: order,
          **options
        }.compact
        
        result = call_endpoint("coins_markets", params)
        return Failure(result.error) if result.failure?

        coins = result.data.map { |coin_data| ResponseEntities::Coin.new(coin_data) }
        Success(coins)
      end

      def self.info(id: "bitcoin", **options)
        params = {
          localization: false,
          tickers: false,
          developer_data: false,
          sparkline: false,
          **options
        }.compact
        
        result = call_endpoint("coin_info", params, id: id)
        return Failure(result.error) if result.failure?

        coin_info = ResponseEntities::CoinInfo.new(result.data)
        Success(coin_info)
      end
    end
  end
end
