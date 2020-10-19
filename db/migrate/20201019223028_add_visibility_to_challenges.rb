class AddVisibilityToChallenges < ActiveRecord::Migration[6.0]
  def change
    add_column :challenges, :visibility, :integer, default: 0
  end
end
