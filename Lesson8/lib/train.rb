class Train
  include Manufacturer
  include InstanceCounter
  include Validator

  VALID_NUMBER = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  attr_reader :number, :wagons, :type
  attr_accessor :route
  @@trains = {}

  def initialize(params)
    @number = params[:number]
    register_instance
    @wagons = []
    @speed = 0
    @@trains[number] = self
    validate!
  end

  def self.find(number)
    @@trains[number]
  end

  def find_wagon(number)
    res = @wagons.select { |wagon| wagon.number == number }
    res.first
  end

  def speed_up(value = 1)
    if value < 0 || current_speed >= 200
      nil
    elsif @speed + value > 200
      @speed += (@speed + value) - 200
    else
      @speed += value
    end
  end

  def speed_down(value = 1)
    @speed = @speed >= value ? @speed -= value : @speed = 0
  end

  def stop
    @speed = 0
  end

  def current_speed
    @speed
  end

  def setup_route(route)
    @route = route
    @station_index = 0
    route.stations.first.trains << self
  end

  def current_station
    @current_station = @route.stations[@station_index]
  end

  def last_station
    @route.stations.last.name if @route
  end

  def next_station
    @route.stations[@station_index + 1].name if @route
  end

  def move_forward
    return if last_station?
    current_station.train_out(self)
    @station_index += 1
    current_station.take_train(self)
  end

  def move_backward
    return if first_station?
    current_station.train_out(self)
    @station_index -= 1 if @station_index
    current_station.take_train(self)
  end

  def add_wagons(wagon)
    if stay?
      @wagons << wagon
    else
      p 'Нельзя прицеплять вагоны на ходу. Сбросьте скорость'
    end
  end

  def delete_wagons(wagons = 1)
    if @speed.zero?
      @wagons -= wagons
    else
      p 'Нельзя отцеплять вагоны на ходу. Сбросьте скорость'
    end
  end

  def stay?
    @speed.zero?
  end

  def last_station?
    current_station == @route.stations.last
  end

  def first_station?
    current_station == @route.stations.first
  end

  def list_wagons
    @wagons.each { |wagon| yield(wagon) }
  end

  protected

  # validate format with regular expr
  def validate_format(atr)
    raise TypeError, 'Invalid FORMAT of identifical number(valid example 000-sd)' unless atr =~ VALID_NUMBER
  end

  def validate!
    validate_presence(@number)
    validate_length(@number)
    validate_format(@number)
  end
end
