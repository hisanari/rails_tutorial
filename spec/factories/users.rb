FactoryBot.define do
  factory :user, class: User do
    name { 'foo' }
    email { 'bar@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    remember_digest { '' }
  end
  factory :other, class: User do
    name { 'other' }
    email { 'other@example.com' }
    password { 'hogehoge' }
    password_confirmation { 'hogehoge' }
    remember_digest { '' }
  end
  factory :anonymous, class: User do
    name Faker::Name.name
    sequence(:email) { |n| "anonymous-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    remember_digest { '' }
  end
end
