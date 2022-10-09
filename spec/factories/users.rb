FactoryBot.define do
  factory :user do
    username { 'MyName' }
    email { 'sample@example.com' }
    password { 'foobar' }
  end
end
