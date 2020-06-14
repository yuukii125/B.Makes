class PostsController < ApplicationController
  
  before_action :authenticate_user
  before_action :set_search
  
  # 投稿一覧ページ
  def index
    #ransackを使った検索
    @q = User.joins(:posts).ransack(params[:q])
    @q.sorts = "posts_created_at desc" if @q.sorts.empty?
    @search_results = @q.result(distinct: true)
                      .select("users.*, posts.*")
  end
  
  # 検索ページ
  def search_page
  end

  
  # 投稿詳細ページ
  def show 
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    #いいね 
    @like = Like.new
    @likes_count = Like.where(post_id: @post.id).count 
  end
  

  
  # 新規投稿ページ
  def new
    @post = Post.new
  end
  # 新規投稿されたとき
  def create
    @post = Post.new( menu: params[:menu],
                      gram: params[:gram],
                      calorie: params[:calorie],
                      protein: params[:protein],
                      fat: params[:fat],
                      carb: params[:carb],
                      image: params[:image],
                      purpose: params[:purpose],
                      user_id: @current_user.id
                    )
    # 保存できたらメッセージと投稿一覧ページへ
    if @post.save
      flash[:notice] = "投稿に成功しました！"
      redirect_to posts_url
      # 失敗したらメッセージと新規投稿ページへ
    else
      @post = params[:post]
      flash.now[:notice] = "投稿に失敗しました。メニューと目的は必須です"
      render action: :new
    end
  end

  # 削除
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_url
  end
  
  
      #  検索
    def set_search
      @q = User.joins(:posts).ransack(params[:q])
      @q.sorts = "created_at desc" if @q.sorts.empty?
      @search_posts = @q.result(distinct: true).select("users.*, posts.*")
    end
    
end
