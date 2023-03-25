FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {"abc123"}
    password_confirmation {password}
    family_name           {"漢字かなカナ"}
    first_name            {"漢字かなカナ"}
    family_name_kana      {"カタカナ"}
    first_name_kana       {"カタカナ"}
    birth_day             {"2000-01-01"}
  end
end