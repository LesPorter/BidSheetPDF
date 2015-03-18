class Bid < ActiveRecord::Base
  belongs_to :cabinet
  #validates :cabinet_id, :name, presence: true
  
  belongs_to :granite
  #validates :granite_id, :name, presence: true
end
