FactoryBot.define do
  factory :reaction do
    user { nil }
    reactionable_id { 1 }
    reactionable_type { "MyString" }
    type { "" }
  end
end
