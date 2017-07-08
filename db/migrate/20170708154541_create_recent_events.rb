class CreateRecentEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :recent_events do |t|
      t.string :type
      t.string :repo
      t.datetime :created_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
