class RenameTypeColumnInConfig < ActiveRecord::Migration[7.0]
  def change
    rename_column :config, :type, :dt
  end
end
