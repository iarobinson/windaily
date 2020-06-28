class CreateWins < ActiveRecord::Migration[5.2]
  def change
    create_table :wins do |t|
      t.string :title
      t.text :description
      t.belongs_to :challenge
      t.belongs_to :user
      t.timestamps
    end
  end
end
