class AddCategoriesToLogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :logs, :category, foreign_key: true
  end
end
