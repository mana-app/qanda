class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(25)
  end

  def new
    @user = User.new
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @questions = @user.questions().order(created_at: :desc).page(params[:page]).per(10)
  end

  def answers
    @user = User.find_by(id: params[:id])
    @answers = @user.answers().order(created_at: :desc).page(params[:page]).per(10)
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = @user.likes().order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def create
    @user = User.new(user_params)
    @user.image_name = 'default_user.png'

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ユーザー登録が完了しました'
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  # 編集・削除処理
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:default_image] == 'true'
      @user.image_name = 'default_user.png'
    elsif params[:image]
      if check_size?(params[:image])
        @user.image_name = "#{@user.id}.jpg"
        File.binwrite("public/user_images/#{@user.image_name}", params[:image].read)
      else
        render 'users/edit'
        return
      end
    end

    if @user.save
      flash[:notice] = 'ユーザー情報を編集しました'
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  # ログイン処理
  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = 'ログインに成功しました'
      redirect_to("/questions/index")
    else
      @error_message = 'メールアドレスまたはパスワードが間違っています'
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
    flash[:notice] = 'ログアウトしました'
    redirect_to("/")
  end

  # 他ユーザーの編集不可確認処理
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = '権限がありません'
      redirect_to('/users/index')
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def check_size?(image)
      if image.size > 5.megabytes
        flash[:notice] = '画像サイズを5MB以下にしてください'
        false
      else
        true
      end
    end
end
