class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    new_genre = Genre.new(genre_params)
    if new_genre.save
      redirect_to admin_genres_path
      flash[:success] = "ジャンルを追加しました。"
    else 
      @new_genre = Genre.new(genre_params)
      @genres = Genre.all
      flash.now[:danger] = "ジャンルの追加に失敗しました。"
      render :index
    end 
  end 
  
  def index
    @new_genre = Genre.new
    @genres = Genre.all
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end 
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:success] = "ジャンルを編集しました。"
      redirect_to admin_genres_path
    else 
      flash.now[:danger] = "ジャンルの編集に失敗しました。"
      render :edit
    end 
  end 
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end 
  
end
