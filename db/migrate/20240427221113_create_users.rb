class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.integer :role
      t.integer :group

      t.timestamps
    end
  end
end
