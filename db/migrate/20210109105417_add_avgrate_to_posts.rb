class AddAvgrateToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :avgrate, :float
  end
end
