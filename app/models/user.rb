class User < ApplicationRecord
    # ユーザーには複数の投稿がある
    # 主キーと外部キーの設定
    has_many :posts, primary_key: 'id', foreign_key: 'user_id', dependent: :destroy
    
    mount_uploader :user_img, UserImgUploader
    
    has_many :likes, dependent: :destroy
    
    has_many :liked_posts, through: :likes, source: :post
    
    
    # 空白・（メアドは）重複ダメ
    validates :name, presence: true, length: { maximum: 10}
    validates :email, presence: true, uniqueness: true
    validates :gender, presence: true
    validates :age, presence: true 
    validates :height, presence: true 
    validates :weight, presence: true
    
    
    has_secure_password
    # パスワードは空白ダメ・6文字以上、新規登録のときだけ有効
    validates :password, presence: true, length: {minimum: 6}, on: :create
    validates :password_confirmation, presence: true, length: {minimum: 6}, on: :create
    
end
