module Api
  module V1
    class CarsController < ApplicationController
      before_action :set_car, only: [ :show, :update, :destroy ]

      # GET /api/v1/cars
      def index
        @cars = Car.order(created_at: :desc).page(params[:page]).per(10)
        render json: @cars, meta: pagination_meta(@cars)
      end

      # GET /api/v1/cars/:id
      def show
        render json: @car
      end

      # POST /api/v1/cars
      def create
        @car = Car.new(car_params)

        if @car.save
          render json: @car, status: :created, location: api_v1_car_url(@car)
        else
          render json: @car.errors, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/cars/:id
      def update
        if @car.update(car_params)
          render json: @car
        else
          render json: @car.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/cars/:id
      def destroy
        if @car.destroy
          head :no_content
        else
          render json: { error: "No se pudo eliminar el auto" }, status: :unprocessable_entity
        end
      end

      private

      def set_car
        @car = Car.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Car not found" }, status: :not_found
      end

      def car_params
        params.require(:car).permit(:plate_number, :model, :year)
      end

      def pagination_meta(cars)
        {
          current_page: cars.current_page,
          total_pages: cars.total_pages,
          total_count: cars.total_count
        }
      end
    end
  end
end
