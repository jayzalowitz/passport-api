class Timeslot < ActiveRecord::Base
	has_many :timeslot_has_boat
  	has_many :boats, :through => :timeslot_has_boat
  	has_many :bookings
  	before_save :add_times

	def add_times
		self.end_time = self.start_time + self.duration.minutes
	end

	def status
		@status = { 
			id: self.id, 
			start_time: self.start_time.to_i, 
			duration: self.duration, 
			availability: self.max_available_booking, 
			customer_count: self.bookings.map {|booking| booking['size']}.reduce(0, :+),  
			boats: self.boats.map{|boat| boat.id} 
		}
		return @status
	end

	def max_available_booking
		self.match_bookings_to_boats.max.to_i
	end

	def boats_not_in_use
		return self.boats.reject { |boat| boat.in_use?(self) }
	end

	def boats_to_match
		boats_to_match = self.boats_not_in_use.map {|boat| {boat_id: boat['id'] ,capacity: boat['capacity'], unused_capacity: boat.unused_capacity(self)} }
	end

	def boat_available?(size)
		self.max_available_booking >= size
	end

	def find_biggest_available_boat
		boats_to_match = self.boats_to_match
		boats_to_match = boats_to_match.sort_by { |k| k[:unused_capacity] }.reverse!
		boats_to_match[0]		
	end

	def match_bookings_to_boats
		#raise self.boats_to_match.inspect
		self.boats_to_match.map{|boat| boat[:unused_capacity]}
	end
end
