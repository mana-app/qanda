class QuestionsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @questions = Question.all.order(created_at: :desc).page(params[:page]).per(25)
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find_by(id: params[:id])
    # 質問が削除されていないかチェック
    if @question
      @answers = Answer.where(question_id: params[:id]).order(created_at: :asc).page(params[:page]).per(10)
      @question_user = @question.user()
      @likes_count = @question.count_likes()
    else
      flash[:notice] = 'その質問は削除されました'
      redirect_to('/questions/index')
    end
  end

  def create
    @question = Question.new(
      content: params[:content],
      user_id: @current_user.id
    )
    if @question.save
      flash[:notice] = '質問を投稿しました'
      redirect_to("/questions/#{@question.id}")
    else
      render('questions/new')
    end
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:id])
    @question.content = params[:content]
    if @question.save
      flash[:notice] = '質問を編集しました'
      redirect_to("/questions/#{@question.id}")
    else
      render('questions/edit')
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    @question.destroy
    flash[:notice] = '質問を削除しました'
    redirect_to('/questions/index')
  end

  # 他ユーザの編集不可処理
  def ensure_correct_user
    @question = Question.find_by(id: params[:id])
    if @question.user_id != @current_user.id
      flash[:notice] = '権限がありません'
      redirect_to("/questions/index")
    end
  end
end
