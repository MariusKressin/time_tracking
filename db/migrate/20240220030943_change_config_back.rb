class ChangeConfigBack < ActiveRecord::Migration[7.0]
  def change
    rename_table :config, :configs
  end
end
