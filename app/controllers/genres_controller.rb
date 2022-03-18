class GenresController < ApplicationController

  def new
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to new_genre_path
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to new_genre_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
