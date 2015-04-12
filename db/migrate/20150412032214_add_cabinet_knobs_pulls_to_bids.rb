class AddCabinetKnobsPullsToBids < ActiveRecord::Migration
  def change
    add_column :bids, :cabinet_knobspulls, :boolean
  end
end
