class ApplicationController < ActionController::Base
    before_action :set_current_user

    # 投稿可能な文字数
    MAX_CHAR_LENGTH = 3000

    def set_current_user
        if @current_user
            @current_user
        else
            @current_user = User.find_by(id: session[:user_id])
        end
    end

    def authenticate_user
        if @current_user == nil
            flash[:notice] = 'ログインしてください'
            redirect_to('/login');
        end
    end

    def forbid_login_user
        if @current_user
            flash[:notice] = 'すでにログインしています'
            redirect_to('/questions/index')
        end
    end
end
