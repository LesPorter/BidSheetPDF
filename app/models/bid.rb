class Bid < ActiveRecord::Base
  belongs_to :cabinet
  #validates :cabinet_id, :name, presence: true  # Makes database fields required
  
  belongs_to :granite
  #validates :granite_id, :name, presence: true  # Makes database fields required
end
