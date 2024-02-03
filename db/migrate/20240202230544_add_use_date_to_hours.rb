class AddUseDateToHours < ActiveRecord::Migration[7.0]
  def change
    add_column :hours, :use_date, :boolean
  end
end
