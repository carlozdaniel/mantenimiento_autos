# spec/requests/api/v1/cars_spec.rb
require 'rails_helper'

RSpec.describe "API V1 Cars", type: :request do
  let!(:car) { create(:car) }
  let(:valid_attributes) { { plate_number: 'XYZ123', model: 'Civic', year: 2020 } }
  let(:invalid_attributes) { { plate_number: '', year: 1899 } }

  describe "GET /api/v1/cars" do
    it "returns a paginated list of cars" do
      get "/api/v1/cars"
      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Array)
      expect(json_response.size).to be <= 10
    end
  end

  describe "GET /api/v1/cars/:id" do
    it "returns the car" do
      get "/api/v1/cars/#{car.id}"
      expect(response).to have_http_status(:ok)
      expect(json_response['id']).to eq(car.id)
    end

    it "returns not found when car doesn't exist" do
      get "/api/v1/cars/9999"
      expect(response).to have_http_status(:not_found)
      expect(json_response['error']).to eq("Car not found")
    end
  end

  describe "POST /api/v1/cars" do
    it "creates a new car with valid attributes" do
      expect {
        post "/api/v1/cars", params: { car: valid_attributes }
      }.to change(Car, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it "returns an error with invalid attributes" do
      post "/api/v1/cars", params: { car: invalid_attributes }
      expect(response).to have_http_status(422)
    end
  end

  describe "PUT /api/v1/cars/:id" do
    it "updates the car with valid attributes" do
      put "/api/v1/cars/#{car.id}", params: { car: valid_attributes }
      expect(response).to have_http_status(:ok)
      expect(json_response['plate_number']).to eq('XYZ123')
    end

    it "returns an error with invalid attributes" do
      put "/api/v1/cars/#{car.id}", params: { car: invalid_attributes }
      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE /api/v1/cars/:id" do
    it "deletes the car" do
      expect {
        delete "/api/v1/cars/#{car.id}"
      }.to change(Car, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns an error if the car cannot be deleted" do
      allow_any_instance_of(Car).to receive(:destroy).and_return(false)
      delete "/api/v1/cars/#{car.id}"
      expect(response).to have_http_status(422)
    end
  end
end
