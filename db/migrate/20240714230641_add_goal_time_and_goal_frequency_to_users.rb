class AddGoalTimeAndGoalFrequencyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :goal_time, :float
    add_column :users, :goal_frequency, :integer
  end
end
