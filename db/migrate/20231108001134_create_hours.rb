class CreateHours < ActiveRecord::Migration[7.0]
  def change
    create_table :hours do |t|
      t.datetime :begin
      t.datetime :end
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
