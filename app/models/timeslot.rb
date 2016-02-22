class Timeslot < ActiveRecord::Base
	has_many :timeslot_has_boat
  	has_many :boats, :through => :timeslot_has_boat
  	has_many :bookings

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
		self.match_bookings_to_boats.max
	end

	def match_bookings_to_boats
		@boats_to_match = self.boats.map {|boat| {capacity: boat['capacity'], unused_capacity: boat['capacity']} }
		puts @boats_to_match.inspect
		self.bookings.each do |booking|
			@boats_to_match.sort_by { |k| k[:unused_capacity] }
			puts @boats_to_match.inspect
			largest_capacity = @boats_to_match.first
			largest_capacity[:unused_capacity] = largest_capacity[:unused_capacity] - booking.size
			@boats_to_match[0] = largest_capacity
		end
		puts @boats_to_match.inspect
		return @boats_to_match.map{|boat| boat[:unused_capacity]}
	end
end
