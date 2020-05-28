class RemoveUserImgToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :user_img ,:string
  end
end
