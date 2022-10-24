FactoryBot.define do
  factory :reaction do
    user { nil }
    reactable_id { 1 }
    reactable_type { 'MyString' }
    type { '' }
  end
end
