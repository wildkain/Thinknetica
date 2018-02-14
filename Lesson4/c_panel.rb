
require_relative "lib/station.rb"
require_relative "lib/train.rb"
require_relative "lib/route.rb"
require_relative "lib/passenger_train.rb"
require_relative "lib/cargo_train.rb"
require_relative "lib/wagon.rb"
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
  until answer == "exit" || answer == 0  do
    make_line
    p "Enter '1' to  create a Station "
    p "Enter '2' to  create a Train "
    p "Enter '3' to  create a Route(need min 2 Stations) "
    p "Enter '4' to  edit a route"
    p "Enter '5' to  assign_route"
    p "Enter '6' to  add wagon to train "
    p "Enter '7' to  remove wagon from train "
    p "Enter '8' to  depart train from station"
    p "Enter '9' to  show list of stations and trains "
    p "Enter '0' or 'exit' to go out"
    make_line
    answer  = gets.chomp.to_i
    menu_items(answer)
  end
end


def menu_items(answer)
  case answer
    when 1 then create_station
    when 2 then create_train
    when 3 then create_route
    when 4 then manage_routes unless @routes.empty?
    when 5 then assign_route unless @routes.empty? || @trains.empty?
    when 6 then add_wagon_to_train 
    when 7 then remove_wagon_from_train
    when 8 then depart_train
    when 9 then show_station
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
		p "Route '#{first_station.name} => #{last_station.name}'  was created"
	else
		p "Unable to create route. First point equal last"
	end

end

def manage_routes
  p "Choose route to edit(add or delete stations)"
	@routes.each_with_index do |route, index|
		make_line("-r-")
		p "Route - #{index}"
		route.stations.each { |station| p "#{station.name}"}
		make_line("-r-")
  end

  input = gets.chomp.to_i
  route = @routes[input]
  p "Route to edit - - #{route.stations.first.name} => #{route.stations.last.name}"
  p "Enter 1 if you want to add station to route"
  p "Enter 2 if you want to delete station"
  case gets.chomp.to_i
    when 1
      p "Enter number of station"
      show_created_stations
      station = @stations[gets.chomp.to_i - 1]
      route.add_to_list(station)
    when 2    # тут баг, но я еще вернусь
      p "Enter number of station"
      route.print_list
      station = @stations[gets.chomp.to_i]
      p "Station #{station.name} was removed"
      route.delete_station(station)
  end

end

def assign_route
  p "Look and choose train"
  show_created_trains 
  train = @trains[gets.chomp.to_i - 1]
  p "Look and choose route"
  show_created_routes 
  route = @routes[gets.chomp.to_i - 1]
  train.setup_route(route)
  p "Route #{route} was assign to #{train}"
end

#добавление вагона к поезду
def add_wagon_to_train

	show_created_trains
	p "Enter train's number to add wagon"
	number = gets.chomp.to_i
  train = @trains.find {|tr| tr.number == number }
  train.class == PassengerTrain ? wagon = PassengerWagon.new : wagon = CargoWagon.new
	train.add_wagons(wagon)	
end

#отцепка вагона от поезад
def remove_wagon_from_train
  show_created_trains
  p "Enter train's number to remove wagon"
  number = gets.chomp.to_i
  train = @trains.find {|tr| tr.number == number }
  train.wagons.pop
end

#перемещение поезда


#список станций 


#список поездов



private

def show_created_routes
  @routes.each.with_index(1) { |route, index| p "#{index} ---  #{route.stations.first.name} => #{route.stations.last.name}" }
end

def show_created_trains
  @trains.each.with_index(1) { |train, index| p "#{index} - - #{train}"}
end

def show_created_stations
  @stations.each.with_index(1) {|station, index| p "#{index} - #{station.name}"}
end


	
def make_line(char="-")
  p char * 30
end

end

#new_menu  = ControlPanel.new

train1 = PassengerTrain.new(555)