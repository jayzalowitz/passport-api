class Boat < ActiveRecord::Base
	has_many :timeslot_has_boat
  	has_many :timeslots, :through => :timeslot_has_boat
  	has_many :bookings
	#todo test
	#todo assertions
	#todo associations
	def in_use?(current_timeslot)
		start_time = current_timeslot.start_time + 1.second
		end_time = current_timeslot.end_time - 1.second
		timeslots = []
		Timeslot.where(end_time: start_time..current_timeslot.end_time).reject{|timeslot| timeslot.id == current_timeslot.id}.each{|time| timeslots.push(time.id)} 
		Timeslot.where(start_time: current_timeslot.start_time..end_time).reject{|timeslot| timeslot.id == current_timeslot.id}.each{|time| timeslots.push(time.id)} 
		Booking.where(timeslot_id: timeslots, boat_id: self.id).length > 0
	end

	def unused_capacity(current_timeslot)
		self.capacity - self.used_capacity(current_timeslot)
	end

	def used_capacity(current_timeslot)
		puts Booking.where(timeslot_id: current_timeslot.id, boat_id: self.id).map{|booking| booking['size']}.inspect
		Booking.where(timeslot_id: current_timeslot.id, boat_id: self.id).map{|booking| booking['size']}.reduce(0, :+)
	end
end
