class Post < ApplicationRecord
    # 投稿は一人のユーザーに属する
    # 主キーと外部キーの設定
    belongs_to :user, foreign_key: 'user_id', primary_key: 'id'
    
    
    has_many :likes, dependent: :destroy
    
    has_many :liked_users, through: :likes, source: :user
    
    mount_uploader :image, ImageUploader
    
    # menu,user_idは必須
    validates :menu, presence: true
    validates :user_id, presence: true
    
    def user
        User.find(self.user_id)
    end
    

end
