class AddGraniteTaxToBids < ActiveRecord::Migration
  def change
    add_column :bids, :granite_tax, :boolean
  end
end
