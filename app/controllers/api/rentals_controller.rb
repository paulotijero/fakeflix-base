module Api
  class Api::RentalsController < ApplicationController

    def index
      case
      when params[:rentable_type]
        render json: Rental.where(rentable_type: params["rentable_type"])
      else
        render json: Rental.all
      end
    end

    def movies
      movie = Movie.find(params[:id])
      rental_movie = movie.rentals.create(
        paid_price: movie.price
      )
      render json: rental_movie, status: :created
    end

    def series
      serie = Serie.find(params[:id])
      rental_serie = serie.rentals.create(
        paid_price: serie.price
      )
      render json: rental_serie, status: :created
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

  end
end
