class MoviesController < ApplicationController

  before_filter :find_actor, :find_producer, :find_director, :only => [:create]

  def new
    @actors = User.where("role = ?", "actor")
    @directors = User.where("role = ?", "director")
    @producers = User.where("role = ?", "producer")
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.users << @actor
    @movie.users << @producer
    @movie.users << @director
    @movie.save
    redirect_to movies_path
  end

  def index
    @movies = Movie.all
  end

  private

  def movie_params
    params.require(:movie).permit(:title)
  end

  def find_actor
    binding.pry
    @actor = User.find(params[:actor_id])
  end

  def find_producer
    @producer = User.find(params[:producer_id])
  end

  def find_director
    @director = User.find(params[:director_id])
  end
end