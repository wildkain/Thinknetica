require_relative 'lib/modules/validator.rb'
require_relative 'lib/modules/manufacturer.rb'
require_relative 'lib/modules/instance_counter.rb'
require_relative 'lib/station.rb'
require_relative 'lib/train.rb'
require_relative 'lib/route.rb'
require_relative 'lib/passenger_train.rb'
require_relative 'lib/cargo_train.rb'
require_relative 'lib/wagon.rb'
require_relative 'lib/passenger_wagon.rb'
require_relative 'lib/cargo_wagon.rb'

class ControlPanel
  attr_accessor :stations, :trains, :routes
  attr_reader :wagons

  def initialize
    @trains = []
    @stations = []
    @routes = []
    @wagons = []
    @errors = []
    @wagon_index = 0
  end

  def menu
    p '|||--------------RAILWAY CONTROL PANEL-----------------|||'
    answer = 1
    until answer.zero?
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
      p "Enter '11' to show free wagons in depo"
      p "Enter '12' to show train's wagons"
      p "Enter '13' to POPULATE RAILROAD"
      p "Enter '14' to load wagon or buy ticket"
      p "Enter '0 to go out"
      output_errors unless @errors.empty?
      @errors = []
      make_line
      answer = gets.chomp.to_i
      menu_items(answer)
    end
  end

  def menu_items(answer)
    actions =
      { 1 => method(:create_station), 2 => method(:create_train),
        3 => method(:create_route), 4 => method(:manage_routes),
        5 => method(:assign_route), 6 => method(:add_wagon_to_train),
        7 => method(:remove_wagon_from_train), 8 => method(:depart_train),
        9 => method(:list_stations), 10 => method(:show_trains_on_station),
        11 => method(:show_free_wagons), 12 => method(:show_wagons_for_train),
        13 => method(:populate_railroad), 14 => method(:load_wagon) }
    actions[answer].call if actions.key?(answer)
  end

  def create_station
    params = {}
    begin
      p 'Enter station name'
      params[:name] = gets.chomp.to_s
      @stations << Station.new(params)
    rescue RuntimeError => error
      p error.message.to_s
      retry
    rescue NameError => error
      p error.message.to_s
      retry
    end
    p "Station '#{params[:name]}' was created" unless error
  end

  def create_train
    p "Enter train's type. '1' - Passenger. '2' - Cargo"
    type = gets.chomp.to_i
    begin
      p 'Enter Trains number'
      params = { number: gets.chomp }
      case type
      when 1 then @train = PassengerTrain.new(params)
      when 2 then @train = CargoTrain.new(params)
      else
        p 'Enter please only 1 or 2.'
      end
    rescue RuntimeError => error
      p error.message.to_s
      retry
    rescue NameError => error
      p error.message.to_s
      retry
    rescue TypeError => error
      p error.message.to_s
      retry
    end
    p "Train  #{@train.type} #{@train.number} was created" if @train
    @train ? @trains << @train : nil
  end

  def create_route
    return if @stations.size < 2
    begin
      p 'Select first point of route'
      p 'Available point based on your creations:'
      show_created_stations
      p "Please, enter station's number"
      first = gets.chomp.to_i
      first_station = @stations[first - 1]
      p "Your choice  -  #{first_station.name}"
      p 'Choose destination station'
      show_created_stations
      last = gets.chomp.to_i
      last_station = @stations[last - 1]
      p "Your choice  -  #{last_station.name}"
      if first_station != last_station
        @route = Route.new(first_station, last_station)
        @routes << @route
        p "Route '#{first_station.name} => #{last_station.name}'  was created"
      else
        p 'Unable to create route. First point equal last'
      end
    rescue RuntimeError => error
      p error.message.to_s
      retry
    end
  end

  def manage_routes
    return no_route if @routes.empty?
    p 'Choose route to edit(add or delete stations)'
    @routes.each_with_index do |route, index|
      make_line('-r-')
      p "Route - #{index}"
      route.stations.each { |station| p station.name.to_s }
      make_line('-r-')
    end
    input = gets.chomp.to_i
    route = @routes[input]
    p "Route to edit: #{route.stations.first.name}-#{route.stations.last.name}"
    p 'Enter 1 if you want to add station to route'
    p 'Enter 2 if you want to delete station'
    case gets.chomp.to_i
    when 1
      p 'Enter number of station'
      show_created_stations
      station = @stations[gets.chomp.to_i - 1]
      route.add_to_list(station)
    when 2
      route.modify? ? manage_routes_part(route) : @errors << "Can't be modify"
    else
      p 'Bad choice'
    end
  end

  def assign_route
    return no_route if @routes.empty?
    return no_train if @trains.empty?
    p 'Look and choose train'
    show_created_trains_no_index
    number = gets.chomp
    train = find_train(number)
    p 'Look and choose route'
    show_created_routes
    route = @routes[gets.chomp.to_i - 1]
    train.setup_route(route)
    p "Route #{route} was assign to #{train}"
  end

  def add_wagon_to_train
    show_created_trains_no_index
    begin
      p "Enter train's number to add wagon"
      number = gets.chomp
      train = find_train(number)
      if train.is_a?(PassengerTrain)
        p 'Enter number of seats of wagon'
        seats = gets.chomp.to_i
        wagon = PassengerWagon.new(@wagon_index += 1, seats)
      else
        p 'Enter cargo volume of wagon'
        volume = gets.chomp.to_i
        wagon = CargoWagon.new(@wagon_index += 1, volume)
      end
      train.add_wagons(wagon)
    rescue RuntimeError => error
      p error.message.to_s
      retry
    end
  end

  def remove_wagon_from_train
    return no_train if @trains.empty?
    show_created_trains_no_index
    p "Enter train's number to remove wagon"
    number = gets.chomp.to_i
    train = find_train(number)
    return @errors << 'No wagons found' if train.wagons.empty?
    @wagons << train.wagons.last
    train.wagons.pop
  end

  def depart_train
    return @errors << 'No trains found' if @trains.empty?
    p 'Look at list of trains and take one by number'
    show_created_trains_no_index
    number = gets.chomp.to_i
    train = find_train(number)
    return @errors << 'Assign a route to train first' if train.route.nil?
    p 'Forward or Backward?'
    p 'Type 1 for train forward, or 2 to train backward'
    input = gets.chomp.to_i
    case input
    when 1
      train.move_forward unless train.route.nil? || train.last_station?
      p "Train #{train.number} departed to #{train.current_station.name}"
    when 2
      train.move_backward unless train.route.nil? || train.first_station?
      p "Train #{train.number} departed to #{train.current_station.name}"
    else
      p 'Bad choice'
    end
  end

  def list_stations
    show_created_stations
  end

  def show_trains_on_station
    return if @stations.empty?
    p "Choose station by enter station's number"
    list_stations
    station = @stations[gets.chomp.to_i - 1]
    return no_train if station.trains.empty?
    station.list_trains do |train|
      p "Number\Type\Wagon: #{train.number}|#{train.type}|#{train.wagons.count}"
    end
  end

  def show_wagons_for_train
    show_created_trains_no_index
    p "Enter train's number to list wagons"
    number = gets.chomp
    train = find_train(number)
    if train.is_a?(PassengerTrain)
      train.list_wagons do |wagon|
        p "Number: #{wagon.number}, Model: #{wagon.model}," \
           " Free seats: #{wagon.free_places}," \
           " Busy: #{wagon.busy_places}"
      end
    else
      train.list_wagons do |wagon|
        p "Number: #{wagon.number}, Model: #{wagon.model}," \
          "Free space: #{wagon.free_space}," \
         "Loaded: #{wagon.loaded_space}"
      end
    end
  end

  def load_wagon
    show_wagons_for_train
    w_number = gets.chomp.to_i
    wagon = train.find_wagon(w_number)
    wagon.is_a?(PassengerWagon) ? load_pass(wagon) : load_cargo(wagon)
  end

  def populate_railroad
    params_tr = { number: '000-sd' }
    params_st1 = { name: 'Voronezh' }
    params_st2 = { name: 'Moscow' }
    tr1 = PassengerTrain.new(params_tr)
    @trains << tr1
    w1 = PassengerWagon.new(1, 5)
    tr1.add_wagons(w1)
    st1 = Station.new(params_st1)
    st2 = Station.new(params_st2)
    @stations.push(st1, st2)
    @routes.push(rt = Route.new(st1, st2))
    tr1.setup_route(rt)
  end

  private

  def manage_routes_part(route)
    p 'Enter number of station'
    route.print_list
    station = @stations[gets.chomp.to_i]
    p "Station '#{station.name}' was removed"
    route.delete_station(station)
  end

  def show_created_trains_no_index
    @trains.each { |train| p "Train's number: #{train.number}" }
  end

  def find_train(number)
    @trains.find { |tr| tr.number == number }
  end

  def show_created_routes
    @routes.each.with_index(1) do |route, index|
      p "#{index} - #{route.stations.first.name} => #{route.stations.last.name}"
    end
  end

  def show_created_stations
    @stations.each.with_index(1) do |station, index|
      p "#{index} - #{station.name}"
    end
  end

  def show_free_wagons
    @passenger = @wagons.find_all { |w| w.is_a?(PassengerWagon) }
    @cargo = @wagons.find_all { |w| w.is_a?(CargoWagon) }
    p 'Free wagons on stations: '
    p "Passenger - #{@passenger.size}"
    p "Cargo     - #{@cargo.size}"
  end

  def make_line(char = '-')
    p char * 30
  end

  def output_errors
    @errors.each do |error|
      make_line('-E-')
      p error
    end
  end

  def load_pass(wagon)
    p 'Choose free seat(enter number) and seat down'
    p wagon.free_places(&:keys)
    place = gets.chomp.to_i
    wagon.load_passenger(place)
    p "Place '#{place}' is yours"
  end

  def load_cargo(wagon)
    p 'Choose volume of cargo'
    volume = gets.chomp.to_i
    wagon.load_space(volume)
    p "Uploaded in wagon number:#{wagon.number} || Volume : #{volume}"
  end

  def no_route
    @errors << 'No ROUTES found'
  end

  def no_train
    @errors << 'No TRAINS  found'
  end
end
