class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :set_current_user

  
  
    
    #ログインしているユーザーの特定
    def set_current_user  
        @current_user = User.find_by(id: session[:user_id])
    end 
    
    # ログインしていないユーザーの制限
    def authenticate_user
        unless @current_user
            flash[:notice] = "ログインしてください"
            redirect_to "/login"
        end
    end
    
    # ログインしているユーザーの制限
    def limitation_login_user
        if @current_user
            flash[:notice] = "すでにログインしています"
            redirect_to "/posts"
        end
    end
    

end
