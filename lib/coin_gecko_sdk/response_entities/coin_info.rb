module CoinGeckoSdk
  module ResponseEntities
    class CoinInfo
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :id, :string
      attribute :symbol, :string
      attribute :name, :string
      attribute :description, :string
      attribute :image, :string
      attribute :market_cap_rank, :integer
      attribute :coingecko_rank, :integer
      attribute :coingecko_score, :decimal
      attribute :developer_score, :decimal
      attribute :community_score, :decimal
      attribute :liquidity_score, :decimal
      attribute :public_interest_score, :decimal
      attribute :market_data, :string
      attribute :community_data, :string
      attribute :developer_data, :string
      attribute :public_interest_stats, :string
      attribute :status_updates, :string
      attribute :last_updated, :datetime
      attribute :localization, :string
      attribute :web_slug, :string
      attribute :asset_platform_id, :string
      attribute :platforms, :string
      attribute :detail_platforms, :string
      attribute :category, :string
      attribute :genesis_date, :datetime
      attribute :coingecko_url, :string
      attribute :tickers, :string
      attribute :homepage, :string
      attribute :block_time_in_minutes, :integer
      attribute :hashing_algorithm, :string
      attribute :categories, :string
      attribute :public_notice, :string
      attribute :additional_notices, :string
      attribute :links, :string
      attribute :logo, :string
      attribute :subreddit, :string
      attribute :repos_url, :string
      attribute :image, :string
      attribute :content_banner, :string
      attribute :content_banner_url, :string
    end
  end
end
