class CreateGranites < ActiveRecord::Migration
  def change
    create_table :granites do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
