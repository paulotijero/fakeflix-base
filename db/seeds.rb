movie_id = 1
serie_id = 1

100.times do
  Movie.create(
    title: "Mo - #{movie_id}",
    description: "Description Mo - #{movie_id}",
    rating: 0,
    duration: rand(90..180),
    price: rand(5..25),
    status: ["coming_soon", "preorder", "billboard"].sample,
    playback: 0
  )
  Serie.create(
    title: "Se - #{serie_id}",
    description: "Description Se - #{serie_id}",
    rating: 0,
    price: rand(5..25),
    status: ["coming_soon", "preorder", "billboard"].sample
  )
  number_episodes = rand(10..30)
  episode_id = 1
  number_episodes.times do
    Episode.create(
      title: "Ep - #{episode_id} Se - #{serie_id}",
      description: "Description Ep - #{episode_id} Se - #{serie_id}",
      duration: rand(45..120),
      playback: 0,
      serie_id: serie_id
    )
    episode_id += 1
  end
  movie_id += 1
  serie_id += 1
end

rentals_id = 1
available_movies = Array(1..(movie_id-1))
available_series = Array(1..(serie_id-1))
100.times do
  type = ["Movie", "Serie"].sample
  rental = Rental.create(
    paid_price: rand(5..50),
    rentable_type: type,
    rentable_id: type == "Movie" ? available_movies.sample : available_series.sample
  )
  type == "Movie" ? available_movies.delete(rental[:rentable_id]) : available_series.delete(rental[:rentable_id])
  rentals_id += 1
end