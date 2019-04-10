module Api
  class Api::SeriesController < ApplicationController
    
    def index
      render json: Serie.all.as_json(
        methods: [:rented, :total_duration],
        include: {episodes: {only: [:id, :title]}}
      )
    end

    def show
      render json: Serie.find(params[:id]).as_json(
        methods: [:rented, :total_duration],
        include: {episodes: {only: [:id, :title]}}
      )
    end

    def rating
      serie = Serie.find(params[:id])
      serie.rating = params[:attributes][:rating]
      serie.save
      render json: serie
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

  end
end
