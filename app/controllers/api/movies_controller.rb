module Api
  class Api::MoviesController < ApplicationController

    def index
      case
      when params[:status]
        render json: Movie.where(status: params["status"]).as_json(methods: [:rented])
      else
        movie = Movie.all.as_json(methods: [:rented])
        render json: movie
      end
    end

    def show
      render json: Movie.find(params[:id]).as_json(methods: [:rented])
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
