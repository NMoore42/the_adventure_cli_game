class CreateCarriedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :carried_items do |t|
      t.integer :player_id
      t.integer :item_id
      #this is new code, it lives on the the test branch - not the master
    end
  end
end
