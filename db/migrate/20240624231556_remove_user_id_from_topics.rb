class RemoveUserIdFromTopics < ActiveRecord::Migration[7.0]
  def change
    remove_reference :topics, :user, null: false, foreign_key: true
  end
end
