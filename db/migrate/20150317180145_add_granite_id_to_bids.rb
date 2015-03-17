class AddGraniteIdToBids < ActiveRecord::Migration
  def change
    add_column :bids, :granite_id, :integer
  end
end
