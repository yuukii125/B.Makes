class AddmenuToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :menu, :text
  end
end
