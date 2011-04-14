class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :category
      t.string :address_2
      t.string :phone
      t.string :latitude
      t.string :longitude
      t.textarea :description
      t.integer :event_id
      t.integer :type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
