class ChangeDataUserImgToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :user_img, :string
  end
end
