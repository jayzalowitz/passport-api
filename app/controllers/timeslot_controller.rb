class TimeslotController < ApplicationController
  def create
  	timeslot = params[:timeslot]
  	#todo check params for correctness
  	start_time = DateTime.strptime(timeslot[:start_time].to_s,'%s')
  	@created_timeslot = Timeslot.create(:start_time => start_time,:duration => timeslot[:duration])
  	render json: @created_timeslot.status
  end

  def show
  	date = params[:date].to_datetime
  	time_range = date..(date + 1.day)
  	@timeslots = Timeslot.where( start_time: time_range )
  	render json: @timeslots.map{|ts| ts.status}
  end

  def book
  	booking = params[:booking]
  	timeslot = Timeslot.find(booking[:timeslot_id])
  	#this needs to figure out if there is enough space in the timeslot before booking
  	#this is a very serious bug that will lead to unhappy users but i need to get everything else working first.
  	Booking.create(timeslot_id: timeslot.id,size: booking[:size])
  	render json: {}
  end
end
