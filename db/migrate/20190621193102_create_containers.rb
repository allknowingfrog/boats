class CreateContainers < ActiveRecord::Migration[5.2]
  def change
    create_table :containers do |t|
      t.references :shipment, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
