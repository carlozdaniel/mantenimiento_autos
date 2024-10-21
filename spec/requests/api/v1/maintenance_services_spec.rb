# spec/requests/api/v1/maintenance_services_spec.rb
require 'rails_helper'

RSpec.describe "API V1 MaintenanceServices", type: :request do
  let!(:car) { create(:car) }
  let!(:maintenance_service) { create(:maintenance_service, car: car) }
  let(:valid_attributes) { { description: "Cambio de aceite", status: "pending", date: Date.today } }
  let(:invalid_attributes) { { description: "", status: "pending", date: Date.tomorrow } }

  describe "GET /api/v1/cars/:car_id/maintenance_services" do
    it "returns a list of maintenance services" do
      get "/api/v1/cars/#{car.id}/maintenance_services"
      expect(response).to have_http_status(:ok)
      expect(json_response.size).to eq(1)
    end
  end

  describe "GET /api/v1/cars/:car_id/maintenance_services/:id" do
    it "returns the specific maintenance service" do
      get "/api/v1/cars/#{car.id}/maintenance_services/#{maintenance_service.id}"
      expect(response).to have_http_status(:ok)
      expect(json_response['id']).to eq(maintenance_service.id)
    end

    it "returns not found when the maintenance service doesn't exist" do
      get "/api/v1/cars/#{car.id}/maintenance_services/9999"
      expect(response).to have_http_status(:not_found)
      expect(json_response['error']).to eq("Maintenance service not found")
    end
  end

  describe "POST /api/v1/cars/:car_id/maintenance_services" do
    it "creates a new maintenance service with valid attributes" do
      expect {
        post "/api/v1/cars/#{car.id}/maintenance_services", params: { maintenance_service: valid_attributes }
      }.to change(MaintenanceService, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it "returns an error with invalid attributes" do
      post "/api/v1/cars/#{car.id}/maintenance_services", params: { maintenance_service: invalid_attributes }
      expect(response).to have_http_status(422)
    end
  end

  describe "PUT /api/v1/cars/:car_id/maintenance_services/:id" do
    it "updates the maintenance service with valid attributes" do
      put "/api/v1/cars/#{car.id}/maintenance_services/#{maintenance_service.id}", params: { maintenance_service: valid_attributes }
      expect(response).to have_http_status(:ok)
    end

    it "returns an error with invalid attributes" do
      put "/api/v1/cars/#{car.id}/maintenance_services/#{maintenance_service.id}", params: { maintenance_service: invalid_attributes }
      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE /api/v1/cars/:car_id/maintenance_services/:id" do
    it "deletes the maintenance service" do
      expect {
        delete "/api/v1/cars/#{car.id}/maintenance_services/#{maintenance_service.id}"
      }.to change(MaintenanceService, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
