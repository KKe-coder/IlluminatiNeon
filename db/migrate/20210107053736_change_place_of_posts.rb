class ChangePlaceOfPosts < ActiveRecord::Migration[5.2]

  def up
    change_column :posts, :place, :integer, default: 0
  end

  def down
    change_column :posts, :place, :integer, default: 0
  end

end
