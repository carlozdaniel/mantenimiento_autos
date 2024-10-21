class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]

  # GET /cars or /cars.json
  def index
    @cars = Car.page(params[:page]).per(10)
  end

  # GET /cars/1 or /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: "El auto fue creado exitosamente." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: "El auto fue actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    if @car.destroy
      respond_to do |format|
        format.html { redirect_to cars_path, notice: "El auto fue eliminado exitosamente." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @car, alert: "No se pudo eliminar el auto." }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:plate_number, :model, :year)
  end
end
