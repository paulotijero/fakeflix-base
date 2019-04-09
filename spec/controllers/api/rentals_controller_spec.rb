require 'rails_helper'

RSpec.describe Api::RentalsController, type: :controller do

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
    @rental_movie = Rental.create(
      paid_price: 10,
      rentable_type: "Movie",
      rentable_id: @movie.id
    )
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'render json with all' do
      get :index
      rental = JSON.parse(response.body)
      expect(rental.size).to eq 2
    end
    it 'returns http status ok with all rentable_type' do
      get :index, params: { rentable_type: @rental_movie.rentable_type }
      expect(response).to have_http_status(:ok)
    end
    it 'render json with all rental-movies' do
      get :index, params: { rentable_type: "Movie" }
      rental = JSON.parse(response.body)
      expect(rental.size).to eq 1
    end
    it 'render json with all rental-serie' do
      get :index, params: { rentable_type: "Serie" }
      rental = JSON.parse(response.body)
      expect(rental.size).to eq 1
    end
  end

  describe "POST movies" do
    it "returns http status movies" do
      post :movies, params: { 
        id: @movie.id
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end
    it "returns the created movies" do
      post :movies, params: { 
        id: @movie.id
      }
      expected_rental_movie = JSON.parse(response.body)
      expect(expected_rental_movie).to have_key("id")
      expect(expected_rental_movie["paid_price"]).to eq(@movie.price)
    end
  end

  describe "POST series" do
    it "returns http status series" do
      post :series, params: { 
        id: @serie.id
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end
    it "returns the created series" do
      post :series, params: { 
        id: @serie.id
      }
      expected_rental_serie = JSON.parse(response.body)
      expect(expected_rental_serie).to have_key("id")
      expect(expected_rental_serie["paid_price"]).to eq(@serie.price)
    end
  end

end
