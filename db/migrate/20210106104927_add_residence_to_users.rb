class AddResidenceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :residence, :integer, default: 0
  end
end
