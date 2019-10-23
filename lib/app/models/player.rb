class Player < ActiveRecord::Base
  has_many :carried_items
  has_many :items, through: :carried_items

end
