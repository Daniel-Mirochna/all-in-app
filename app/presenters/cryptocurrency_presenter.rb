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
    if number.positive?
      "<span style='display: inline-block; color: rgb(101 163 13);'><svg xmlns='http://www.w3.org/2000/svg'
        fill='none' viewBox='0 0 24 24' stroke-width='2.5' stroke='currentColor'
        style='display: inline; width: 10px; height: 10px; vertical-align: initial;'>
        <path stroke-linecap='round' stroke-linejoin='round' d='M4.5 15.75l7.5-7.5 7.5 7.5' />
      </svg>&thinsp;#{number.round(2)}&thinsp;%</span>".html_safe
    else
      "<span style='display: inline-block; color: rgb(220 38 38);'><svg xmlns='http://www.w3.org/2000/svg'
        fill='none' viewBox='0 0 24 24' stroke-width='2.5' stroke='currentColor'
        style='display: inline; width: 10px; height: 10px; vertical-align: initial;'>
        <path stroke-linecap='round' stroke-linejoin='round' d='M19.5 8.25l-7.5 7.5-7.5-7.5' />
      </svg>&thinsp;#{number.round(2).to_s.gsub('-', '')}&thinsp;%</span>".html_safe
    end
  end
end
