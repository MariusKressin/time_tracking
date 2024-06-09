class AddGNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :gname, :string
  end
end
