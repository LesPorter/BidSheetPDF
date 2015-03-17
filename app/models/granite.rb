class Granite < ActiveRecord::Base
  has_many :bids
  mount_uploader :image, ImageUploader
end