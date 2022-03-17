class DiariesController < ApplicationController

  def new
    @diary = Diary.new
  end

  def create
    diary = Diary.new(diary_params)
    diary.save
    redirect_to diaries_path
  end

  def index
   @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    @diary.update(diary_params)
    redirect_to diary_path(@diary)
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.delete
    redirect_to diaries_path
  end


  private


  def diary_params
    params.require(:diary).permit(:title, :url, :img_id, :sentence, :learning_time)
  end
end
