class ChangeConfigsToConfig < ActiveRecord::Migration[7.0]
  def change
    rename_table :configs, :config
  end
end
