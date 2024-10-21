FactoryBot.define do
  factory :maintenance_service do
    description { "Cambio de aceite" }
    status { "pending" }
    date { Date.today }
    car
  end
end
