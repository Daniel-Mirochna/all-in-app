require 'rails_helper'

RSpec.describe CoinGeckoApi, type: :model do
  describe '.ping' do
    let(:response) { CoinGeckoApi.ping }

    it 'returns a successful response' do
      expect(response.code).to eq(200)
    end
  end

  describe '.coins_list' do
    let(:response) { CoinGeckoApi.coins_list }
    let(:response_body_mockup) { JSON.parse(File.read("spec/support/fixtures/coin_gecko_api/coins_list.json")) }

    it 'returns a successful response' do
      expect(response.code).to eq(200)
    end

    it 'has content type application/json' do
      expect(response.headers["content-type"]).to eq("application/json; charset=utf-8")
    end

    it 'has specified keys' do
      expect(response.first.keys).to eq(response_body_mockup.first.keys)
    end
  end
end
