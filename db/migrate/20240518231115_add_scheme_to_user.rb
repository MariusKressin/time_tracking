class AddSchemeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :scheme, :string
  end
end
