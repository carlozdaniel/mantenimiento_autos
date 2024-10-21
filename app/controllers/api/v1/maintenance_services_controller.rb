module Api
  module V1
    class MaintenanceServicesController < ApplicationController
      before_action :set_car
      before_action :set_maintenance_service, only: [ :show, :update, :destroy ]

      # GET /api/v1/cars/:car_id/maintenance_services
      def index
        @maintenance_services = @car.maintenance_services

        if params[:status].present?
          @maintenance_services = @maintenance_services.where(status: params[:status])
        end

        @maintenance_services = @maintenance_services.page(params[:page]).per(10)
        render json: @maintenance_services, meta: pagination_meta(@maintenance_services)
      end

      # GET /api/v1/cars/:car_id/maintenance_services/:id
      def show
        render json: @maintenance_service
      end

      # POST /api/v1/cars/:car_id/maintenance_services
      def create
        @maintenance_service = @car.maintenance_services.new(maintenance_service_params)

        if @maintenance_service.save
          render json: @maintenance_service, status: :created, location: api_v1_car_maintenance_service_url(@car, @maintenance_service)
        else
          render json: @maintenance_service.errors, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/cars/:car_id/maintenance_services/:id
      def update
        if @maintenance_service.update(maintenance_service_params)
          render json: @maintenance_service
        else
          render json: @maintenance_service.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/cars/:car_id/maintenance_services/:id
      def destroy
        if @maintenance_service.destroy
          head :no_content
        else
          render json: { error: "No se pudo eliminar el servicio de mantenimiento" }, status: :unprocessable_entity
        end
      end

      private

      def set_car
        @car = Car.find(params[:car_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Car not found" }, status: :not_found
      end

      def set_maintenance_service
        @maintenance_service = @car.maintenance_services.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Maintenance service not found" }, status: :not_found
      end

      def maintenance_service_params
        params.require(:maintenance_service).permit(:description, :status, :date)
      end

      def pagination_meta(maintenance_services)
        {
          current_page: maintenance_services.current_page,
          total_pages: maintenance_services.total_pages,
          total_count: maintenance_services.total_count
        }
      end
    end
  end
end
