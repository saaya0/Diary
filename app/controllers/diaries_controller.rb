class DiariesController < ApplicationController

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save #勉強時間によってポイント数変更
      if @diary.learning_time.to_i >= 10
        @diary.point = 5.to_s
      elsif @diary.learning_time.to_i < 10 && @diary.learning_time.to_i > 6
        @diary.point = 4.to_s
      elsif @diary.learning_time.to_i == 6 || @diary.learning_time.to_i == 5
        @diary.point = 3.to_s
      elsif @diary.learning_time.to_i == 4 || @diary.learning_time.to_i == 3
        @diary.point = 2.to_s
      else
        @diary.point = 1.to_s
      end
      @diary.save
      flash[:success] = "日記登録ができました。 #{@diary.point}ポイント獲得！"
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
    @sum = @diaries_time.sum(:point)
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
