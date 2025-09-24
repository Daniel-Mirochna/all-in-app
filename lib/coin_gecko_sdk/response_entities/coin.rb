module CoinGeckoSdk
  module ResponseEntities
    class Coin
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :id, :string
      attribute :symbol, :string
      attribute :name, :string
      attribute :image, :string
      attribute :current_price, :decimal
      attribute :market_cap, :decimal
      attribute :market_cap_rank, :integer
      attribute :fully_diluted_valuation, :decimal
      attribute :total_volume, :decimal
      attribute :high_24h, :decimal
      attribute :low_24h, :decimal
      attribute :price_change_24h, :decimal
      attribute :price_change_percentage_24h, :decimal
      attribute :market_cap_change_24h, :decimal
      attribute :market_cap_change_percentage_24h, :decimal
      attribute :circulating_supply, :decimal
      attribute :total_supply, :decimal
      attribute :max_supply, :decimal
      attribute :ath, :decimal
      attribute :ath_change_percentage, :decimal
      attribute :ath_date, :datetime
      attribute :atl, :decimal
      attribute :atl_change_percentage, :decimal
      attribute :atl_date, :datetime
      attribute :roi, :string
      attribute :last_updated, :datetime
    end
  end
end
