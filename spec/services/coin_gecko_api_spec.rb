require "rails_helper"

RSpec.describe CoinGeckoApiService do
  describe ".ping" do
    let(:response) { CoinGeckoApiService.ping }

    it "returns a successful response" do
      expect(response.code).to eq(200)
    end
  end

  describe ".coins_list" do
    let(:response) { CoinGeckoApiService.coins_list }
    let(:response_body_mockup) { JSON.parse(File.read("spec/support/fixtures/coin_gecko_api/coins_list.json")) }

    it "returns a successful response" do
      expect(response.code).to eq(200)
    end

    it "has content type application/json" do
      expect(response.headers["content-type"]).to eq("application/json; charset=utf-8")
    end

    it "has specified keys" do
      expect(response.first.keys).to eq(response_body_mockup.first.keys)
    end
  end

  describe ".coin_info" do
    # let(:response) { CoinGeckoApiService.coin_info("bitcoin") }
    let(:coin_gecko_api) { CoinGeckoApiService }

    it "accepts the coin_id parameter" do
      coin_id = "bitcoin"
      coin_info_response = { "id" => "bitcoin", "name" => "Bitcoin", "symbol" => "btc" }

      allow(coin_gecko_api).to receive(:coin_info).with(coin_id).and_return(coin_info_response)
      result = coin_gecko_api.coin_info(coin_id)
      expect(result).to eq(coin_info_response)
    end
  end
end
