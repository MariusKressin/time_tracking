class CreateConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :configs do |t|
      t.string :key
      t.string :value
      t.string :type

      t.timestamps
    end
  end
end
