class GenresController < ApplicationController

  def new
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:success] = "ジャンル登録成功しました！"
      redirect_to new_genre_path
    else
      @genres = Genre.all
      flash[:error] = "名前の重複、文字数（3～10文字）をご確認ください"
      render :new
    end
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
