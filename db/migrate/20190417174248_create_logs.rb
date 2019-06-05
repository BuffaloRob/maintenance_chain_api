class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :notes
      t.string :tools
      t.integer :cost
      t.date :date_performed
      t.date :date_due

      t.timestamps
    end
  end
end
