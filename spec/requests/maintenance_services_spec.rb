# spec/requests/maintenance_services_spec.rb
require 'rails_helper'

RSpec.describe "MaintenanceServices", type: :request do
  let!(:car) { create(:car) }
  let!(:maintenance_service) { create(:maintenance_service, car: car) }
  let(:valid_attributes) { { description: "Cambio de aceite", status: "pending", date: Date.today } }
  let(:invalid_attributes) { { description: "", status: "pending", date: Date.tomorrow } }

  describe "GET /cars/:car_id/maintenance_services" do
    it "returns a list of maintenance services" do
      get car_maintenance_services_path(car)
      expect(response).to have_http_status(:ok)
      expect(assigns(:maintenance_services)).to eq([ maintenance_service ])
    end
  end

  describe "GET /cars/:car_id/maintenance_services/:id" do
    it "returns the specific maintenance service" do
      get car_maintenance_service_path(car, maintenance_service)
      expect(assigns(:maintenance_service)).to eq(maintenance_service)
    end
  end

  describe "POST /cars/:car_id/maintenance_services" do
    it "creates a new maintenance service with valid attributes" do
      expect {
        post car_maintenance_services_path(car), params: { maintenance_service: valid_attributes }
      }.to change(MaintenanceService, :count).by(1)
      expect(response).to redirect_to(car_maintenance_services_path(car))
    end

    it "does not create a maintenance service with invalid attributes" do
      expect {
        post car_maintenance_services_path(car), params: { maintenance_service: invalid_attributes }
      }.to_not change(MaintenanceService, :count)
      expect(response).to have_http_status(422)  # Cambiado a 422
    end
  end

  describe "PATCH/PUT /cars/:car_id/maintenance_services/:id" do
    it "updates the maintenance service with valid attributes" do
      patch car_maintenance_service_path(car, maintenance_service), params: { maintenance_service: valid_attributes }
      expect(response).to redirect_to(car_maintenance_services_path(car))
    end

    it "does not update the maintenance service with invalid attributes" do
      patch car_maintenance_service_path(car, maintenance_service), params: { maintenance_service: invalid_attributes }
      expect(response).to have_http_status(422)  # Cambiado a 422
    end
  end

  describe "DELETE /cars/:car_id/maintenance_services/:id" do
    it "deletes the maintenance service" do
      expect {
        delete car_maintenance_service_path(car, maintenance_service)
      }.to change(MaintenanceService, :count).by(-1)
      expect(response).to redirect_to(car_maintenance_services_path(car))
    end
  end
end
