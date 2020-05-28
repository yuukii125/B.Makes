class RemovePostfromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :post, :text
  end
end
