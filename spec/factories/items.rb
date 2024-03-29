FactoryBot.define do
  factory :item do
    name                  {"スカート"}
    description           {"未使用です"}
    category_id           {"2"}
    item_condition_id     {"2"}
    shipping_fee_id       {"2"}
    prefecture_id         {"2"}
    shipping_date_id      {"2"}
    price                 {"5000"}
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
