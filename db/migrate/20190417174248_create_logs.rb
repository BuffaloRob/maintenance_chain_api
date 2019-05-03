class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :notes
      t.string :tools
      t.integer :cost
      t.datetime :date_performed
      t.datetime :date_due
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
