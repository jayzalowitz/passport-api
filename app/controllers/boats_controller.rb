class BoatsController < ApplicationController
  
  def create
  	#todo more graceful failing, needs to return json specifying failure reason if no create, for now need to get app working 
  	boat = params[:boat]
  	#todo check to see if name is string and and capacity is a > 0 int
  	@new_boat = Boat.create(name: boat[:name], capacity: boat[:capacity])

  	render json: {
  	  id: @new_boat.id,
      name: @new_boat.name,
      capacity: @new_boat.capacity
    }.to_json
  end

  def show
  	@boats = Boat.all.map{|boat| {id: boat.id,name: boat.name,capacity: boat.capacity}}
  	render json: @boats.to_json
  end

  def assign
  end
end
