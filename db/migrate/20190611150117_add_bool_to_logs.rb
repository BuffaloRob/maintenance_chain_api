class AddBoolToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :active, :boolean, null: false, default: true
  end
end
