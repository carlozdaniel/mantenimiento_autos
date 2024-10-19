module Api
  module V1
    class MaintenanceServicesController < ApplicationController
      before_action :set_maintenance_service, only: [ :show, :update, :destroy ]

      # GET /api/v1/maintenance_services
      def index
        @maintenance_services = MaintenanceService.all
        render json: @maintenance_services
      end

      # GET /api/v1/maintenance_services/:id
      def show
        render json: @maintenance_service
      end

      # POST /api/v1/maintenance_services
      def create
        @maintenance_service = MaintenanceService.new(maintenance_service_params)

        if @maintenance_service.save
          render json: @maintenance_service, status: :created
        else
          render json: @maintenance_service.errors, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/maintenance_services/:id
      def update
        if @maintenance_service.update(maintenance_service_params)
          render json: @maintenance_service
        else
          render json: @maintenance_service.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/maintenance_services/:id
      def destroy
        @maintenance_service.destroy
        head :no_content
      end

      private

      def set_maintenance_service
        @maintenance_service = MaintenanceService.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Maintenance service not found" }, status: :not_found
      end

      def maintenance_service_params
        params.require(:maintenance_service).permit(:car_id, :description, :status, :date)
      end
    end
  end
end
