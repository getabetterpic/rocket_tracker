FactoryBot.define do
  factory :user do
    name { 'Jamie' }
    email { 'jamie@fraser.com' }
    sub { 'provider|1234' }
  end
end
