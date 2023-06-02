class CryptocurrencyPresenter
  attr_reader :coin

  def initialize(coin)
    @coin = coin
  end

  def simple_id
    coin['id']
  end

  def simple_rank
    coin['market_cap_rank']
  end

  def simple_symbol
    coin['symbol'].upcase
  end

  def simple_name
    coin['name']
  end

  def simple_icon
    coin['image']
  end

  def simple_price
    coin['current_price']
  end

  def simple_price_change_percentage_24h
    coin['price_change_percentage_24h']
  end

  def simple_market_cap
    coin['market_cap']
  end

  def simple_fdv
    coin["fully_diluted_valuation"]
  end

  def simple_last_updated
    coin['last_updated'].to_datetime.in_time_zone.strftime("%H:%M")
  end

  def fdv_mktcap_ratio
    if simple_fdv.nil? || simple_fdv.zero?
      "-"
    else
      simple_market_cap.to_f / simple_fdv
    end
  end

  def price_change_percentage(number)
    return "-" if number.nil?

    if number.positive?
      "<span class='relative price-change-up' style='display: inline-block; color: rgb(101 163 13); font-weight: 500;'>
      #{number.round(2)}&thinsp;%</span>".html_safe
    else
      "<span class='relative price-change-down' style='display: inline-block; color: rgb(220 38 38); font-weight: 500;'>
      #{number.round(2).to_s.gsub('-', '')}&thinsp;%</span>".html_safe
    end
  end
end
