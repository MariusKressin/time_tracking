class AddRateToTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :rate, :integer
  end
end
