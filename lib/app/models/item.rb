class Item < ActiveRecord::Base
  has_many :carried_items
  has_many :players, through: :carried_items

end
