class AddMonikerToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :moniker, :string
  end
end
