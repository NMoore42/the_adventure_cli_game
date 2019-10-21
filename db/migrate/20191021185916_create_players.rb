class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :health
      t.integer :gold
      t.string :current_room
    end
  end
end
