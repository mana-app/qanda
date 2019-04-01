class LikesController < ApplicationController
    before_action :authenticate_user

    def create
        @like = Like.new(user_id: @current_user.id, question_id: params[:id])
        @like.save
        redirect_to("/questions/#{params[:id]}")
    end

    def destroy
        @like = Like.find_by(user_id: @current_user.id, question_id: params[:id])
        @like.destroy
        redirect_to("/questions/#{params[:id]}")
    end
end