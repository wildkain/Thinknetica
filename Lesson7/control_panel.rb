require_relative "lib/modules/validator.rb"
require_relative "lib/modules/manufacturer.rb"
require_relative "lib/modules/instance_counter.rb"
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
  attr_reader :wagons
@@wagon_index = 0

  def initialize
    @trains = []
    @stations = []
    @routes = []
    @wagons = []
    @errors = []
  end

  def menu
    p "|||--------------RAILWAY CONTROL PANEL-----------------|||"
    answer ||= nil
    until answer == 0   do
      make_line
      p "Enter '1' to  create a Station "
      p "Enter '2' to  create a Train "
      p "Enter '3' to  create a Route(need min 2 Stations) "
      p "Enter '4' to  edit a route"
      p "Enter '5' to  assign_route"
      p "Enter '6' to  add wagon to train "
      p "Enter '7' to  remove wagon from train "
      p "Enter '8' to  depart train from station"
      p "Enter '9' to  show list of stations "
      p "Enter '10' to  show list of trains on station "
      p "Enter  '11' to show free wagons in depo"
      p "Enter '0 to go out"
      output_errors unless @errors.empty?
      @errors = []
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
      when 4 then  manage_routes
      when 5 then assign_route
      when 6 then add_wagon_to_train
      when 7 then remove_wagon_from_train
      when 8 then depart_train
      when 9 then  list_stations
      when 10 then show_trains_on_station unless @stations.empty? || @trains.empty?
      when 11 then show_free_wagons

    end
  end

  def create_station
    params = {}
    begin
    p "Enter station name"
    name = gets.chomp.to_s
    params[:name] = name
    @stations << Station.new(params)
    rescue RuntimeError => error
      p "#{error.message}"
      error=nil
      retry
    rescue NameError => error
      p  "#{error.message}"
      error=nil
      retry
    end
    p "Try else" if error
    p "Station #{name} was created" unless error
  end



  def create_train
    p "Enter train's type. '1' - Passenger. '2' - Cargo"
    type = gets.chomp.to_i
    begin
    p "Enter Trains number"
    number= gets.chomp
    params = {number: number}
    case type
      when 1 then @train  = PassengerTrain.new(params)
      when 2 then @train = CargoTrain.new(params)
    else
      p "Enter please only 1 or 2."
    end

    rescue RuntimeError => error
      p "#{error.message}"
      retry
    rescue NameError => error
      p  "#{error.message}"
      retry
    rescue TypeError => error
      p  "#{error.message}"
      retry
    end
    p "Train  #{@train.type} #{@train.number} was created" if @train
    @train ? @trains << @train : nil
    p "Try else" if error

  end

  def create_route
    # нужны 2 обьекта станции как минимум.
    return if @stations.size < 2
    begin
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
    rescue RuntimeError => error
      p "#{error.message}"
      retry
    end
  end

  def manage_routes
    return no_route if @routes.empty?
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
      when 2
        route.stations.size < 3 ? @errors << "Route can't be modifed(minimum 2 points must be)" : manage_routes_part(route)
    end
  end

  def assign_route
    return no_route if @routes.empty?
    return no_train if @trains.empty?
    p "Look and choose train"
    show_created_trains_no_index
    number = gets.chomp.to_i
    train = find_train(number)
    p "Look and choose route"
    show_created_routes
    route = @routes[gets.chomp.to_i - 1]
    train.setup_route(route)
    p "Route #{route} was assign to #{train}"
  end

#добавление вагона к поезду
  def add_wagon_to_train
    show_created_trains_no_index
    begin
      p "Enter train's number to add wagon"
      number = gets.chomp
      train = find_train(number)
      train.is_a?(PassengerTrain) ? wagon = PassengerWagon.new(@@wagon_index+=1) : wagon = CargoWagon.new(@@wagon_index+=1)
      train.add_wagons(wagon)
    rescue RuntimeError => error
      p "#{error.message}"
    retry
    end
  end

#отцепка вагона от поезад
  def remove_wagon_from_train
    return no_train if @trains.empty?

    show_created_trains_no_index
    p "Enter train's number to remove wagon"
    number = gets.chomp.to_i
    train = find_train(number)
    return @errors << "No wagons found" if train.wagons.empty?
    @wagons << train.wagons.last
    train.wagons.pop
  end

#перемещение поезда
  def depart_train
    return @errors << "No trains found" if @trains.empty?
    p "Look at list of trains and take one by number"
    show_created_trains_no_index
    number = gets.chomp.to_i
    train = find_train(number)
    return @errors << "Assign a route to train first" if train.route.nil?
    p "Forward or Backward?"
    p "Type 1 for train forward, or 2 to train backward"
    input= gets.chomp.to_i
      case input
        when 1
          train.move_forward unless train.route.nil? || train.last_station?
          p "Train #{train.number} departed to #{train.current_station.name}"
        when 2
          train.move_backward unless train.route.nil? || train.first_station?
          p "Train #{train.number} departed to #{train.current_station.name}"
        end
  end

#список станций
  def list_stations
    show_created_stations
  end

#список поездов
  def show_trains_on_station
    p "Choose station by enter station's number"
    list_stations
    station  = @stations[gets.chomp.to_i - 1]
    return no_train  if station.trains.empty?
    station.list_trains
  end

private

  def manage_routes_part(route)
    p "Enter number of station"
    route.print_list
    station = @stations[gets.chomp.to_i]
    p "Station #{station.name} was removed"
    route.delete_station(station)
  end

  def show_created_trains_no_index
    @trains.each { |train| p "Train's number: #{train.number}"}
  end

  def find_train(number)
    @trains.find {|tr| tr.number == number }
  end

  def show_created_routes
    @routes.each.with_index(1) { |route, index| p "#{index} ---  #{route.stations.first.name} => #{route.stations.last.name}" }
  end

  def show_created_stations
    @stations.each.with_index(1) {|station, index| p "#{index} - #{station.name}" }
  end

  def show_free_wagons
    @passenger = @wagons.find_all { |w| w.is_a?(PassengerWagon) }
    @cargo = @wagons.find_all { |w| w.is_a?(CargoWagon) }
    p "Free wagons on stations: "
    p "Passenger - #{@passenger.size}"
    p "Cargo     - #{@cargo.size}"
  end

  def make_line(char="-")
    p char * 30
  end

  def output_errors
    @errors.each do |error|
      make_line("-E-")
      p error
      end
    end

  def no_route
    @errors << "No ROUTES found"
  end

  def no_train
    @errors << "No TRAINS  found"
  end
end
