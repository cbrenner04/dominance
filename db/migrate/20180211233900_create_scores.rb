class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.references :user, foreign_key: true, null: false
      t.references :round, foreign_key: true, null: false
      t.integer :value, null: false

      t.timestamps
    end
  end
end
