FactoryBot.define do
  factory :buyer_donation do
    token {"tok_abcdefghijk00000000000000000"}
    post_code          {"460-0008"}
    area_id            {24}
    municipality       {"愛知県名古屋市中区栄"}
    address            {"３丁目１３−２０"}
    building_name      {""}
    phone_number       {"05031873522"}
    user_id            {"1"}
    item_id            {"1"}
  end
end