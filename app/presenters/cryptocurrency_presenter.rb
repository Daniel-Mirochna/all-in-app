class CryptocurrencyPresenter
  attr_reader :coin

  def initialize(coin)
    @coin = coin
  end

  def fdv_mktcap_ratio
    if coin["fully_diluted_valuation"].nil?
      "-"
    else
      coin["market_cap"].to_f / coin["fully_diluted_valuation"]
    end
  end

  def price_change_percentage(number)
    return "-" if number.nil?
    if number.positive?
      "<span class='relative price-change-up' style='display: inline-block; color: rgb(101 163 13); font-weight: 500;'>#{number.round(2)}&thinsp;%</span>".html_safe
    else
      "<span class='relative price-change-down' style='display: inline-block; color: rgb(220 38 38); font-weight: 500;'>#{number.round(2).to_s.gsub('-', '')}&thinsp;%</span>".html_safe
    end
  end
end
