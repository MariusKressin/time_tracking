class RemoveGroupFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :group
  end
end
