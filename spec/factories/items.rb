FactoryBot.define do
  factory :item do
    association :user
    
    name              {"mono"}
    description       {"ものです"}
    category_id       { 2 }
    status_id         { 2 }
    burden_id         { 2 }
    area_id           { 2 }
    days_id           { 2 }
    price             {300}

    after(:build) do |item|
      item.image.attach(io: File.open('Hair/hero.jpg'), filename: 'hero.jpg', content_type: 'image/jpg')
    end
  end
end