FactoryBot.define do
  factory :car do
    plate_number { "ABC123" }
    model { "Sedan" }
    year { 2020 }
  end
end
