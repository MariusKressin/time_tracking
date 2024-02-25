class CreateTemplateHours < ActiveRecord::Migration[7.0]
  def change
    create_table :template_hours do |t|
      t.integer :hours
      t.integer :minutes
      t.references :topic, null: false, foreign_key: true
      t.references :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
