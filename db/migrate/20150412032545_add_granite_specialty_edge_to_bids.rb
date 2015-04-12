class AddGraniteSpecialtyEdgeToBids < ActiveRecord::Migration
  def change
    add_column :bids, :granite_specialtyedge, :boolean
  end
end
