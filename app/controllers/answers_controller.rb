class AnswersController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

    def create
        # 回答の上限を100件までにする
        @answers_count = Answer.where(question_id: params[:id]).count()
        if @answers_count >= 100
            flash[:error_message] = '回答できるのは100件までです'
            redirect_to("/questions/#{params[:id]}#answer-form")
            return
        end

        @answer = Answer.new(
            question_id: params[:id],
            content: params[:content],
            user_id: @current_user.id
        )

        if @answer.save
            flash[:notice] = '回答を投稿しました'
            redirect_to("/questions/#{params[:id]}#post")
        else
            if params[:content] == ''
                flash[:error_message] = 'contentを入力してください'
                redirect_to("/questions/#{params[:id]}#answer-form")
            else
                flash[:content] = params[:content]
                flash[:notice] = '回答の投稿に失敗しました'
                flash[:error_message] = 'Contentは2000文字以内で入力してください'
                redirect_to("/questions/#{params[:id]}#answer-form")
            end
        end
    end

    def edit
        @answer = Answer.find_by(id: params[:id])
    end

    def update
        @answer = Answer.find_by(id: params[:id])
        @answer.content = params[:content]
        @question = @answer.question()
        if @answer.save
            flash[:notice] = '回答を編集しました'
            flash[:answer_id] = @answer.id
            redirect_to("/questions/#{@question.id}#update")
        else
            render("answers/edit")
        end
    end

    def destroy
        @answer = Answer.find_by(id: params[:id])
        @question = @answer.question()
        @answer.destroy
        flash[:notice] = '回答を削除しました'
        redirect_to("/questions/#{@question.id}")
    end

    def ensure_correct_user
        @answer = Answer.find_by(id: params[:id])
        @question = @answer.question()
        if @answer.user_id != @current_user.id
            flash[:notice] = '権限がありません'
            redirect_to("/questions/#{@question.id}")
        end
    end
end