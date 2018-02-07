class Train
  attr_reader :number, :type, :wagons
  attr_accessor :route

  def initialize(number, type, wagons)
    @number    = number
    @type      = type
    @wagons = wagons.to_i
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def say_route
    p self.route.stations if self.route
  end

  def setup_route(route)
    self.route = route
    @station_index = 0
  end

  def current_station
    @current_station = self.route.stations[@station_index]
  end

  def last_station
    p self.route.stations.last
  end

  def next_station
    p self.route.stations[@station_index + 1].name
  end

  def move_forward
    @station_index += 1
    self.route.stations[@station_index - 1].train_out(self)
    self.route.stations[@station_index].take_train(self)
  end

  def move_backward
    @station_index -= 1 if @station_index != 0
    self.route.stations[@station_index + 1].train_out(self)
    self.route.stations[@station_index].take_train(self)
  end

  def add_wagons(vagons = 1)
    stop
    @wagons += vagons
  end

  def delete_wagons(vagons = 1)
    stop
    @wagons -= vagons
  end
end
