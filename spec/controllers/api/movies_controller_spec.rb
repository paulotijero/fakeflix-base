require 'rails_helper'

RSpec.describe Api::MoviesController, type: :controller do

  before do
    @movie = Movie.create(
      title: "El titulo",
      description: "La descripcion",
      rating: 2,
      duration: 5,
      price: 100,
      playback: 0,
      status: "coming_soon"
    )
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'render json with all movies' do
      get :index
      movies = JSON.parse(response.body)
      expect(movies.size).to eq 1
    end
    it 'returns http status ok with filter to status' do
      get :index, params: { status: @movie.status }
      expect(response).to have_http_status(:ok)
    end
    it 'render json with filter to status coming-soon' do
      get :index, params: { status: "coming_soon" }
      movies = JSON.parse(response.body)
      expect(movies.size).to eq 1
    end
    it 'render json with filter to status billboard' do
      get :index, params: { status: "billboard" }
      movies = JSON.parse(response.body)
      expect(movies.size).to eq 0
    end
  end

  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: { id: @movie }
      expect(response).to have_http_status(:ok)
    end
    it 'render the correct movie' do
      get :show, params: { id: @movie }
      expected_movie = JSON.parse(response.body)
      expect(expected_movie["id"]).to eq(@movie.id)
    end
    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PATCH playback" do
    it "returns http status ok" do
      patch :playback, params: {
        id: @movie.id,
        attributes: {
          playback: 50
        }
      }
      expect(response).to have_http_status(:ok)
    end
    it "returns the update playback" do
      patch :playback, params: {
        id: @movie.id,
        attributes: {
          playback: 50
        }
      }
      expected_playback = JSON.parse(response.body)
      expect(expected_playback["playback"]).to eq(50)
    end
  end

  describe "PATCH rating" do
    it "returns http status ok" do
      patch :rating, params: {
        id: @movie.id,
        attributes: {
          rating: 5
        }
      }
      expect(response).to have_http_status(:ok)
    end
    it "returns the update playback" do
      patch :rating, params: {
        id: @movie.id,
        attributes: {
          rating: 5
        }
      }
      expected_playback = JSON.parse(response.body)
      expect(expected_playback["rating"]).to eq(5)
    end
  end

end
