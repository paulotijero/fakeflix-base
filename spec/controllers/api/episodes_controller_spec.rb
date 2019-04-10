require 'rails_helper'

RSpec.describe Api::EpisodesController, type: :controller do

  before do
    @serie = Serie.create(
      title: "El titulo",
      description: "La descripcion",
      rating: 2,
      price: 100
    )
    @episode = Episode.create(
      title: "El titulo",
      description: "La descripcion",
      duration: 5,
      serie_id: @serie.id,
      playback: 0
    )
  end
  
  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: { id: @episode }
      expect(response).to have_http_status(:ok)
    end
    it 'render the correct movie' do
      get :show, params: { id: @episode }
      expected_episode = JSON.parse(response.body)
      expect(expected_episode["id"]).to eq(@episode.id)
    end
    it 'render the correct serie id for episode' do
      get :show, params: { id: @episode }
      expected_episode = JSON.parse(response.body)
      expect(expected_episode["serie_id"]).to eq(@episode.serie_id)
    end
    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PATCH playback" do
    it "returns http status ok" do
      patch :playback, params: {
        id: @episode.id,
        attributes: {
          playback: 50
        }
      }
      expect(response).to have_http_status(:ok)
    end
    it "returns the update playback" do
      patch :playback, params: {
        id: @episode.id,
        attributes: {
          playback: 50
        }
      }
      expected_playback = JSON.parse(response.body)
      expect(expected_playback["playback"]).to eq(50)
    end
  end

end
