FactoryBot.define do
  factory :order do
    price_amount { rand(1000) }
    price_currency { 'EUR' }
    receive_currency { 'EUR' }
  end
end
