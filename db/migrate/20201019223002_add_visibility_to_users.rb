class AddVisibilityToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :visibility, :integer, default: 0
  end
end
