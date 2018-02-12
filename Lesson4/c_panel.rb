
require_relative "lib/station.rb"
require_relative "lib/train.rb"
require_relative "lib/route.rb"


require_relative "lib/passenger_train.rb"
require_relative "lib/cargo_train.rb"
require_relative "lib/passenger_wagon.rb"
require_relative "lib/cargo_wagon.rb"


class ControlPanel
	attr_accessor :station, :trains, :routes

def initialize
	@trains = []
	@stations = []
	@routes = []
end
def menu
	p "Hello, Boss. What would you want?"
	answer ||= nil
	until answer == "exit" do
		line
		p "Enter '1' to  create a Station "
		p "Enter '2' to  create a Train "
		p "Enter '3' to  create a Route(need min 2 Stations) "
		p "Enter '4' to  edit a route"
		p "Enter '5' to  create Station "
		p "Enter '6' to  create Station "
		p "Enter '7' to  create Station "
		p "Enter '8' to  create Station "
		p "Enter '9' to  create Station "
		p "Enter '10' to  create Station "
		line
		answer  = gets.chomp.to_i
		menu_items(answer)
	end
end


def menu_items(answer)
	case answer
	when 1 then create_station
	when 2 then create_train
	when 3 then create_route
	when 4 then manage_routes
	when 5 then add_wagon
	when 6 then remove_wagon
	when 7 then depart_train
	when 8 then show_station
	end
end

def create_station
	p "Enter station name"
	name = gets.chomp
	@stations << Station.new(name)
	p "Station #{name} was created"
end

def create_train
	p "Enter Trains number"
	num= gets.chomp.to_i
	p "Enter train's type. '1' - Passenger. '2' - Cargo"
	type = gets.chomp.to_i
	case type
	when 1 then @train  = PassengerTrain.new(num)
	when 2 then @train = CargoTrain.new(num)
	else
		p "Enter please only 1 or 2."
	end
	p "Train  #{@train.type} #{@train.number} was created" if @train
	@trains << @train
end

def create_route
	# нужны 2 обьекта станции как минимум.
	return if @stations.size < 2
	p "Choose first point of route"
	p "Aviable point based on your creations:"
	show_created_stations
	p "Plese, enter station's number"
	first = gets.chomp.to_i
	first_station = @stations[first - 1]
	p "Your choise  -  #{first_station.name}"
	p "Choose destination stattion"
	show_created_stations

	last = gets.chomp.to_i
	last_station = @stations[last - 1]
	p "Your choise  -  #{last_station.name}"
    if first_station != last_station
    	@route = Route.new(first_station, last_station)
    	@routes << @route
		p "Route #{@route.print_list} was created"
	else
		p "Unable to create route. First point equal last"
	end

end

def manage_routes
	p "Choose route to edit"
	@routes.each_with_index {|route, index| p "#{index}  - #{route.print_list}"}
end

def line
	p "_________________________________________"
end



private

def show_created_stations
  @stations.each.with_index(1) {|station, index| p "#{index} - #{station.name}"}
end


end
