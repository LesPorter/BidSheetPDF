class AddCabinetInstallationToBids < ActiveRecord::Migration
  def change
    add_column :bids, :cabinet_installation, :boolean
  end
end
