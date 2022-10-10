FactoryBot.define do
  factory :user do
    trait :zac do
      username { 'zacwilliamson' }
      email { 'zacwilliamson@icloud.com' }
      password { 'password' }
    end

    trait :zoe do
      username { 'zoewilliamson' }
      email { 'zoewilliamson@icloud.com' }
      password { 'password' }
    end
  end
end
