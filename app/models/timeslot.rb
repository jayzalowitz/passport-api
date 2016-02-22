class Timeslot < ActiveRecord::Base
	has_many :timeslot_has_boat
  	has_many :boats, :through => :timeslot_has_boat

	def status
		@status = { 
			id: self.id, 
			start_time: self.start_time.to_i, 
			duration: self.duration, 
			availability: self.boats.map {|boat| boat['capacity']}.reduce(0, :+), 
			customer_count: 0, 
			boats: self.boats.map{|boat| boat.id} 
		}
	end
end
