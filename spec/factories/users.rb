FactoryBot.define do
  factory :user do
    name { 'foo' }
    email { 'bar@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
