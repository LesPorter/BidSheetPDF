class AddCabinetRemovalToBids < ActiveRecord::Migration
  def change
    add_column :bids, :cabinet_removal, :boolean
  end
end
