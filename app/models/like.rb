class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
    
    
    # いいねはuser_id,post_idどちらも必要
    validates :user_id, presence: true
    validates :post_id, presence: true
    # post_idとuser_idの組み合わせは一つだけ
    validates_uniqueness_of :post_id, scope: :user_id
end
