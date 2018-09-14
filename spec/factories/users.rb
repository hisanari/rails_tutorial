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
end
