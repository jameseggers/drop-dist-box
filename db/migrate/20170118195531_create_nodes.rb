class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :address
      t.integer :node_type_id

      t.timestamps
    end
  end
end
