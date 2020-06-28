class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.text :frequency
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.timestamps
    end

    create_table :challenges_users do |t|
      t.belongs_to :user
      t.belongs_to :challenge
    end
  end
end
