class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.text :image_id
      t.integer :category
      t.integer :color
      t.integer :place
      t.float :rate
      t.text :impression

      t.timestamps
    end
  end
end
