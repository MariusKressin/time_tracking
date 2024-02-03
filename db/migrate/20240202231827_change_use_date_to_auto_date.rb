class ChangeUseDateToAutoDate < ActiveRecord::Migration[7.0]
  def change
    rename_column(:hours, :use_date, :auto_date)
  end
end
