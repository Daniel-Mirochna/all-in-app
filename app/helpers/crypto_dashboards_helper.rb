module CryptoDashboardsHelper
  def formatted_price(number)
    number_with_precision(sprintf("%.8f", number), precision: 10, strip_insignificant_zeros: true, delimiter: " ")
  end
end
