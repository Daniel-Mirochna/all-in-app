module CryptocurrenciesHelper
  def formatted_price(number)
    currency = cookies[:currency]
    unless number.nil? || number == "-"
      "#{Cryptocurrency::CURRENCY_SYMBOLS[currency]}&thinsp;#{
        number_with_precision(format('%.8f', number), precision: 10, strip_insignificant_zeros: true, delimiter: ' ')
      }".html_safe
    else
      "-"
    end
  end

  def formatted_number_precision_two(number)
    number_with_precision(number, precision: 2, strip_insignificant_zeros: true)
  end

  def trimmed_link_to(link)
    return unless link

    link_to(link, link, target: "_blank",
                        class: "w-[190px] block font-medium dark:text-purple-400 hover:underline text-ellipsis overflow-hidden")
  end
end
