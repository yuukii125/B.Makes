class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :limitation_login_user, only: [:new, :create, :login_page, :login]
  before_action :limitation_correct_user, only: [:edit, :update]
  
  
  # ユーザー一覧ページ
  def index
    @users = User.all
  end

  # ユーザー詳細ページ
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc)
  end

  # 新規作成
  def new
    @user = User.new
  end
  # 新規作成されたとき
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "登録しました！"
      redirect_to user_url(@user)
    else
      flash.now[:notice] = "登録に失敗しました"
      @name = params[:name]
      @user_img = params[:user_img]
      @email = params[:email]
      @gender = params[:gender]
      @age = params[:age]
      @height = params[:height]
      @weight = params[:weight]
      render action: :new
    end
  end
  
  # 編集
  def edit
    @user = User.find_by(id: params[:id])
  end
  # 編集されたとき
  def update
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.gender = params[:gender]
    @user.age = params[:age]
    @user.height = params[:height]
    @user.weight = params[:weight]
    @user.user_img = params[:user_img]
    if @user.save
      flash[:notice] = "編集しました！"
      redirect_to user_url(@user)
    else
      flash.now[:notice] = "編集に失敗しました。*がついている項目は必須です"
      render action: :edit
    end
  end
  
  
  #削除
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
      flash[:notice] = "アカウントを削除しました"
      redirect_to "/"
  end
  
  # ログイン
  def login_page
  end
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])  #一致するユーザーが存在したとき
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_url
    else
      flash.now[:notice] ="メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render action: :login_page
    end
  end
  
  # ログアウト
  def logout
    session[:user_id] = nil
    reset_session
    flash[:notice] = "ログアウトしました"
    redirect_to "/login"
  end
  
  def limitation_correct_user
    unless @current_user.id == params[:id].to_i
      flash[:notice] = "他のユーザーの編集はできません"
      redirect_to "/posts"
    end
  end
  
  private
  
    def user_params
      params.permit(:name, :user_img, :email, :password, :password_confirmation, :gender, :age, :height, :weight)
    end
    
  
end
