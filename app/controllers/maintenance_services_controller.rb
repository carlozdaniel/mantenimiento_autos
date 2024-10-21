class MaintenanceServicesController < ApplicationController
  before_action :authenticate_user!, :set_car
  before_action :set_maintenance_service, only: %i[show edit update destroy]

  # GET /maintenance_services or /maintenance_services.json
  def index
    @maintenance_services = @car.maintenance_services

    if params[:status].present?
      @maintenance_services = @maintenance_services.where(status: params[:status])
    end

    @maintenance_services = @maintenance_services.page(params[:page]).per(10)
  end

  # GET /maintenance_services/1 or /maintenance_services/1.json
  def show
  end

  # GET /maintenance_services/new
  def new
    @maintenance_service = @car.maintenance_services.new
  end

  # GET /maintenance_services/1/edit
  def edit
  end

  # POST /maintenance_services or /maintenance_services.json
  def create
    @maintenance_service = @car.maintenance_services.new(maintenance_service_params)

    respond_to do |format|
      if @maintenance_service.save
        format.html { redirect_to car_maintenance_services_path(@car), notice: "El servicio de mantenimiento fue creado exitosamente." }
        format.json { render :show, status: :created, location: @maintenance_service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @maintenance_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_services/1 or /maintenance_services/1.json
  def update
    respond_to do |format|
      if @maintenance_service.update(maintenance_service_params)
        format.html { redirect_to car_maintenance_services_path(@car), notice: "El servicio de mantenimiento fue actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @maintenance_service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @maintenance_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_services/1 or /maintenance_services/1.json
  def destroy
    @maintenance_service.destroy
    respond_to do |format|
      format.html { redirect_to car_maintenance_services_path(@car), notice: "El servicio de mantenimiento fue eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

  private

    def set_car
      @car = Car.find(params[:car_id])
    end

    def set_maintenance_service
      @maintenance_service = @car.maintenance_services.find(params[:id])
    end

    def maintenance_service_params
      params.require(:maintenance_service).permit(:description, :status, :date)
    end
end
