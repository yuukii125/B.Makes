class AddNutritionToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :calorie, :integer
    add_column :posts, :protein, :integer
    add_column :posts, :fat, :integer
    add_column :posts, :carb, :integer
  end
end
