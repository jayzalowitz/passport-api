class CreateTimeslotHasBoats < ActiveRecord::Migration
  def change
    create_table :timeslot_has_boats do |t|
      t.integer :timeslot_id
      t.integer :boat_id

      t.timestamps null: false
    end
  end
end
