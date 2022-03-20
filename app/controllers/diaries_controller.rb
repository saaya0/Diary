class DiariesController < ApplicationController

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      flash[:success] = "日記登録ができました。"
      redirect_to diaries_path
    else
      flash[:error] = "タイトル(20文字以内)・日記文(200文字以内)・ジャンルは必須、時間は半角で入力して下さい。"
      render :new
    end
  end

  def index
   @genres = Genre.all
    if params[:genre_id].nil?  #日記一覧をジャンルで絞る
      @diaries = Diary.all.order(created_at: :DESC)
    else
      @diaries = Diary.joins(:genre).where(genres: {id: params[:genre_id]})
    end
    @diaries_time = Diary.all
    @average = @diaries_time.average(:learning_time) #学習時間の平均
    @today_diary = @diaries_time.created_today #今日投稿した日記
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to diary_path(@diary)
    else
      flash[:error] = "タイトル(20文字以内)・日記文(200文字以内)・ジャンルは必須、時間は半角で入力して下さい。"
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path
  end


  private


  def diary_params
    params.require(:diary).permit(:title, :url, :sentence, :learning_time, :genre_id)
  end
end
