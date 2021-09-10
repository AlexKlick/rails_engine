FactoryBot.define do
  factory :item, class: Item do
      name { Faker::Name.name }
      description { Faker::TvShows::BojackHorseman.quote }
      unit_price {rand(1000)}
      merchant_id {rand(Merchant.first.id..Merchant.last.id)}
  end
end

FactoryBot.define do
  factory :item_one_merch, class: Item do
      name { Faker::Name.name }
      description { Faker::TvShows::BojackHorseman.quote }
      unit_price {rand(1000)}
      merchant_id {Merchant.first.id}
  end
end