class Bid < ActiveRecord::Base
  has_one :cabinet
  #validates :cabinet_id, :name, presence: true
  
  has_one :granite
  #validates :granite_id, :name, presence: true
end
