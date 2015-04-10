class AddCabinetTaxToBids < ActiveRecord::Migration
  def change
    add_column :bids, :cabinet_tax, :boolean
  end
end
