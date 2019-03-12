class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :google_id
      t.string :image_url

      t.timestamps
    end
  end
end
