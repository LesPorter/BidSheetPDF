class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :logo
      t.string :client_name
      t.string :project_name
      t.date :date
      t.float :cabinet_cost
      t.float :granite_cost
      t.float :tax_cost
      t.float :total_cost
      t.text :conditions
      t.text :cabinet_mix

      t.timestamps
    end
  end
end
