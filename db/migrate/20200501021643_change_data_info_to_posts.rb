class ChangeDataInfoToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :gram, :float
    change_column :posts, :calorie, :float
    change_column :posts, :protein, :float
    change_column :posts, :fat, :float
    change_column :posts, :carb, :float
  end
end
