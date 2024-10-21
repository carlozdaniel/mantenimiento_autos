# spec/requests/maintenance_services_spec.rb
require 'rails_helper'
require 'cgi'  # Añadido para usar CGI.unescapeHTML

RSpec.describe "MaintenanceServices", type: :request do
  include Devise::Test::IntegrationHelpers  # Incluir helpers de Devise para pruebas de integración

  let!(:user) { create(:user) }  # Crear un usuario para autenticar
  let!(:car) { create(:car) }
  let!(:maintenance_service) { create(:maintenance_service, car: car) }
  let(:valid_attributes) { { description: "Cambio de aceite", status: "pending", date: Date.today } }
  let(:invalid_attributes) { { description: "", status: "pending", date: Date.tomorrow } }

  before do
    sign_in user  # Autenticar al usuario antes de cada prueba
  end

  describe "GET /cars/:car_id/maintenance_services" do
    it "returns a list of maintenance services" do
      get car_maintenance_services_path(car)
      expect(response).to have_http_status(:ok)

      # Desescapar el cuerpo de la respuesta para verificar los mensajes de error
      unescaped_body = CGI.unescapeHTML(response.body)
      expect(unescaped_body).to include("Cambio de aceite")
      expect(unescaped_body).to include("Pending")
      expect(unescaped_body).to include(Date.today.to_s)
    end
  end

  describe "GET /cars/:car_id/maintenance_services/:id" do
    it "returns the specific maintenance service" do
      get car_maintenance_service_path(car, maintenance_service)
      expect(response).to have_http_status(:ok)

      # Desescapar el cuerpo de la respuesta para verificar los mensajes de error
      unescaped_body = CGI.unescapeHTML(response.body)
      expect(unescaped_body).to include("Cambio de aceite")
      expect(unescaped_body).to include("Pending")
      expect(unescaped_body).to include(Date.today.to_s)
    end
  end

  describe "POST /cars/:car_id/maintenance_services" do
    context "with valid attributes" do
      it "creates a new maintenance service" do
        expect {
          post car_maintenance_services_path(car), params: { maintenance_service: valid_attributes }
        }.to change(MaintenanceService, :count).by(1)

        # Verificar redirección después de crear
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(car_maintenance_services_path(car))
      end
    end

    context "with invalid attributes" do
      it "does not create a maintenance service" do
        expect {
          post car_maintenance_services_path(car), params: { maintenance_service: invalid_attributes }
        }.to_not change(MaintenanceService, :count)

        # Verificar que se retorna un error de no procesable
        expect(response).to have_http_status(422)

        # Desescapar el cuerpo de la respuesta para verificar los mensajes de error
        unescaped_body = CGI.unescapeHTML(response.body)
        expect(unescaped_body).to include("Description can't be blank")
        expect(unescaped_body).to include("Date no puede estar en el futuro")
      end
    end
  end

  describe "PATCH/PUT /cars/:car_id/maintenance_services/:id" do
    context "with valid attributes" do
      it "updates the maintenance service" do
        patch car_maintenance_service_path(car, maintenance_service), params: { maintenance_service: { description: "Cambio de filtros" } }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(car_maintenance_services_path(car))

        maintenance_service.reload
        expect(maintenance_service.description).to eq("Cambio de filtros")
      end
    end

    context "with invalid attributes" do
      it "does not update the maintenance service" do
        patch car_maintenance_service_path(car, maintenance_service), params: { maintenance_service: invalid_attributes }
        expect(response).to have_http_status(422)

        maintenance_service.reload
        expect(maintenance_service.description).to_not eq("")

        # Desescapar el cuerpo de la respuesta para verificar los mensajes de error
        unescaped_body = CGI.unescapeHTML(response.body)
        expect(unescaped_body).to include("Description can't be blank")
        expect(unescaped_body).to include("Date no puede estar en el futuro")
      end
    end
  end

  describe "DELETE /cars/:car_id/maintenance_services/:id" do
    it "deletes the maintenance service" do
      expect {
        delete car_maintenance_service_path(car, maintenance_service)
      }.to change(MaintenanceService, :count).by(-1)

      # Verificar redirección después de eliminar
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(car_maintenance_services_path(car))
    end
  end
end
