# frozen_string_literal: true

class MovieFacade
  def self.top_rated
    json = MovieService.top_rated

    @top_rated = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.movie_title_search(query)
    json = MovieService.movie_title_search(query)

    @movie_results = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.movie_id_search(id)
    json = MovieService.movie_id_search(id)
    Movie.new(json)
  end

  def self.movie_reviews(id)
    json = MovieService.movie_reviews(id)
    
    @movie_reviews = json[:results].map do |review|
      Review.new(review)
    end
  end

  def self.movie_cast(id)
    json = MovieService.movie_cast(id)
    
    all_cast = json[:cast].map do |actor|
      CastMember.new(actor)
    end
    @movie_cast = all_cast[0..9]
  end 

end
