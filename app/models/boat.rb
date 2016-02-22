class Boat < ActiveRecord::Base
	has_many :timeslot_has_boat
  	has_many :timeslots, :through => :timeslot_has_boat
	#todo test
	#todo assertions
	#todo associations
end
