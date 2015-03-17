class Bid < ActiveRecord::Base
  has_one :cabinets
  has_one :granites
end
