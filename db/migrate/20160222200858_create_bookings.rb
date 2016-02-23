class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :timeslot_id
      t.integer :boat_id
      t.integer :size
      t.timestamps null: false
    end
  end
end
