require 'rails_helper'

RSpec.describe Car, type: :model do
  it "es válido con un número de placa, modelo y año" do
    car = Car.new(plate_number: "ABC123", model: "Sedan", year: 2020)
    expect(car).to be_valid
  end

  it "no es válido sin un número de placa" do
    car = Car.new(plate_number: nil, model: "Sedan", year: 2020)
    expect(car).not_to be_valid
  end

  it "no es válido con un número de placa duplicado" do
    Car.create!(plate_number: "ABC123", model: "Sedan", year: 2020)
    car = Car.new(plate_number: "ABC123", model: "Hatchback", year: 2021)
    expect(car).not_to be_valid
  end

  it "no es válido si el año es menor que 1900" do
    car = Car.new(plate_number: "ABC123", model: "Sedan", year: 1899)
    expect(car).not_to be_valid
  end

  it "no es válido si el año es mayor que el actual" do
    car = Car.new(plate_number: "ABC123", model: "Sedan", year: Time.now.year + 1)
    expect(car).not_to be_valid
  end
end
