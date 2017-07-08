class RenameColumnInRecentEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :recent_events, :type, :event_type
  end
end
