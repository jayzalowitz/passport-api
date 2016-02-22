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
  end
end
