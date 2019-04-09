require 'rails_helper'

RSpec.describe Api::SeriesController, type: :controller do

  before do
    @serie = Serie.create(
      title: "El titulo",
      description: "La descripcion",
      rating: 2,
      price: 100
    )
    @rental_serie = Rental.create(
      paid_price: 10,
      rentable_type: "Serie",
      rentable_id: @serie.id
    )
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'render json with all series' do
      get :index
      series = JSON.parse(response.body)
      expect(series.size).to eq 1
    end
  end

  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: { id: @serie }
      expect(response).to have_http_status(:ok)
    end
    it 'render the correct serie' do
      get :show, params: { id: @serie }
      expected_serie = JSON.parse(response.body)
      expect(expected_serie["id"]).to eq(@serie.id)
    end
    it 'render the correct serie rented' do
      get :show, params: { id: @serie }
      expected_serie = JSON.parse(response.body)
      expect(expected_serie["rented"]).to eq(@serie.rented)
    end
    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PATCH rating" do
    it "returns http status ok" do
      patch :rating, params: {
        id: @serie.id,
        attributes: {
          rating: 5
        }
      }
      expect(response).to have_http_status(:ok)
    end
    it "returns the update playback" do
      patch :rating, params: {
        id: @serie.id,
        attributes: {
          rating: 5
        }
      }
      expected_playback = JSON.parse(response.body)
      expect(expected_playback["rating"]).to eq(5)
    end
  end

end
