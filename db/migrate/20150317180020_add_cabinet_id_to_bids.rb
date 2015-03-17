class AddCabinetIdToBids < ActiveRecord::Migration
  def change
    add_column :bids, :cabinet_id, :integer
  end
end
