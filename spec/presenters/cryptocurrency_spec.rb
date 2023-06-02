require "rails_helper"

RSpec.describe CryptocurrencyPresenter do
  let(:presenter) { CryptocurrencyPresenter.new(JSON.parse(File.read("spec/support/fixtures/coin_gecko_api/coins_list.json")).first ) }

  context 'fdv_mktcap_ratio' do
    it 'returns hyphen for nil or zero simple_fdv' do
      allow(presenter).to receive(:simple_fdv).and_return(nil)
      expect(presenter.fdv_mktcap_ratio).to eq('-')

      allow(presenter).to receive(:simple_fdv).and_return(0)
      expect(presenter.fdv_mktcap_ratio).to eq('-')
    end

    it 'returns float for non-nil simple_fdv' do
      allow(presenter).to receive(:simple_fdv).and_return(21000000)
      allow(presenter).to receive(:simple_market_cap).and_return(21000000)
      expect(presenter.fdv_mktcap_ratio).to be_instance_of Float

      allow(presenter).to receive(:simple_fdv).and_return(21000000)
      allow(presenter).to receive(:simple_market_cap).and_return(19000000)
      expect(presenter.fdv_mktcap_ratio).to be_instance_of Float
    end
  end
end
