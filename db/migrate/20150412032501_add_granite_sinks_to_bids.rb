class AddGraniteSinksToBids < ActiveRecord::Migration
  def change
    add_column :bids, :granite_sinks, :boolean
  end
end
