class Admin::GenresController < ApplicationController
  def index
    @new_genre = Genre.new
    @genres = Genre.all
  end
end
