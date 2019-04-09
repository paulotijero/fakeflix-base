module Api
  class Api::EpisodesController < ApplicationController

    def show
      render json: Episode.find(params[:id])
    end

    def playback
      episode = Episode.find(params[:id])
      episode.playback = params[:attributes][:playback]
      episode.save
      render json: episode
    end
    
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

  end
end
