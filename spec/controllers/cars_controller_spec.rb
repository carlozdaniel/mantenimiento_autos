require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  include Devise::Test::ControllerHelpers

  # Si usas FactoryBot para crear usuarios
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  let!(:car) { Car.create(plate_number: "ABC123", model: "Sedan", year: 2020) }

  describe "GET #index" do
    it "devuelve una respuesta exitosa" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "devuelve el auto correcto" do
      get :show, params: { id: car.id }
      expect(assigns(:car)).to eq(car)
    end
  end

  describe "POST #create" do
    it "crea un nuevo auto" do
      expect {
        post :create, params: { car: { plate_number: "XYZ987", model: "Hatchback", year: 2021 } }
      }.to change(Car, :count).by(1)
    end
  end
end
