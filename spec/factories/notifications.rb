FactoryBot.define do
  factory :notification do
    user_id { 1 }
    notifiable_id { 1 }
    notifiable_type { "MyString" }
  end
end
