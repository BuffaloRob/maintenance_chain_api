class AddAuth0UserToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth0_user, :string
  end
end
