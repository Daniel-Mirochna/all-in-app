module CoinGeckoSdk
  module ResponseEntities
    module Ping
      class Call
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :gecko_says, :string
      end
    end
  end
end
