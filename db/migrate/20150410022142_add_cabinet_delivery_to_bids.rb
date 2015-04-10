class AddCabinetDeliveryToBids < ActiveRecord::Migration
  def change
    add_column :bids, :cabinet_delivery, :boolean
  end
end
