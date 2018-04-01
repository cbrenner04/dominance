class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.references :game, foreign_key: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
