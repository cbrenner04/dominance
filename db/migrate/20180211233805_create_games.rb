class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.datetime :completed_at

      t.timestamps
    end
  end
end
