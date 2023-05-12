class Cryptocurrency < ApplicationRecord
  CURRENCY_SYMBOLS = {
    "cad" => "$",
    "cny" => "¥",
    "eur" => "€",
    "hkd" => "$",
    "jpy" => "¥",
    "mxn" => "$",
    "pln" => "zł",
    "rub" => "₽",
    "gbp" => "£",
    "usd" => "$"
  }.freeze
end
