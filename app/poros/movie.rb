class Movie 
  attr_reader :id, :title, :runtime, :vote_average 

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @runtime = attributes[:runtime]
    @vote_average = attributes[:vote_average]
  end
end