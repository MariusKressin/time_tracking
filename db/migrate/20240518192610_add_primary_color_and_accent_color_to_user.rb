class AddPrimaryColorAndAccentColorToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :primary_color, :string
    add_column :users, :accent_color, :string
  end
end
