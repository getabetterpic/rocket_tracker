FactoryBot.define do
  factory :motor do
    manufacturer
    code { 'F37W' }
    single_use { false }
    reloadable { true }
    diameter { 29 }
    specs { '' }
    thrust_curve { '' }
  end
end
