class AddGraniteInstallationToBids < ActiveRecord::Migration
  def change
    add_column :bids, :granite_installation, :boolean
  end
end
