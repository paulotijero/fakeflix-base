module Api
  class Api::MoviesController < ApplicationController

    def index
      case
      when params[:status]
        # Mejorar logica para listar solo los rentados.
        render json: Movie.where(status: params["status"])
      else
        render json: Movie.all
      end
    end

    def show
      render json: Movie.find(params[:id])
    end

    def playback
      movie = Movie.find(params[:id])
      movie.playback = params[:attributes][:playback]
      movie.save
      render json: movie
    end

    def rating
      movie = Movie.find(params[:id])
      movie.rating = params[:attributes][:rating]
      movie.save
      render json: movie
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

  end
end
