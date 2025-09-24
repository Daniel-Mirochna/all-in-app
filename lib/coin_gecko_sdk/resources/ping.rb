module CoinGeckoSdk
  module Resources
    class Ping < BaseResource
      def self.call
        result = call_endpoint("ping")
        return Failure(result.error) if result.failure?

        Success(ResponseEntities::Ping::Call.new(result.data))
      end
    end
  end
end
