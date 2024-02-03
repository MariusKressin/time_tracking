class AddShortDescAndLongDescToHours < ActiveRecord::Migration[7.0]
  def change
    add_column :hours, :short_desc, :string
    add_column :hours, :long_desc, :text
  end
end
