# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "json"
require "open-uri"

Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
movie_serialized = URI.open(url).read
movies_json = JSON.parse(movie_serialized)
puts movies_json.class

movies_json["results"].each do |movie|
  movie = Movie.new(
        title: movie["title"],
        overview: movie["overview"],
        rating: movie["vote_average"],
        poster_url: "https://image.tmdb.org/t/p/w500/#{movie["poster_path"]}",
      )
  movie.save
end
