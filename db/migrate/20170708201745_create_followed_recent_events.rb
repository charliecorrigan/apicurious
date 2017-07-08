class CreateFollowedRecentEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :followed_recent_events do |t|
      t.string :event_type
      t.string :login
      t.string :repo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
