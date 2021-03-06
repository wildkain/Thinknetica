class Train
  include Manufacturer
  include InstanceCounter
  include Validator

  attr_reader :number, :wagons, :type , :current_station
  attr_accessor :route
  @@trains = {}

  VALID_NUMBER = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  def initialize(params)
    @number    = params[:number]
    validate!
    register_instance
    @wagons  = []
    @speed = 0
    @@trains[number] = self
  end

  def self.find(number)
    @@trains[number]
  end

  def speed_up(value = 1)
    if value < 0 || current_speed >= 200
      return
    elsif @speed + value > 200
      @speed += (@speed + value) - 200
    else
     @speed += value
    end
  end

  def speed_down(value = 1)
    if @speed >= value
      @speed -= value
    else
      @speed = 0
    end
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

  #избавился от puts, проверка на маршрут
  def current_station
   @current_station = @route.stations[@station_index]
  end

  def last_station
     @route.stations.last.name if @route
  end

  def next_station
    @route.stations[@station_index + 1].name if @route
  end

# добавил проверку на нахождение на конечной. изменил прибытие - убытие со станции.
  def move_forward
    return if last_station?
    current_station.train_out(self)
    @station_index += 1
    current_station.take_train(self)
  end

# добавил проверку на нахождение на начальной станции. изменил прибытие - убытие со станции.
  def move_backward
    return if first_station?
    current_station.train_out(self)
    @station_index -= 1 if @station_index
    current_station.take_train(self)
  end

# добавил проверку скорости
  def add_wagons(wagon)
    if stay?
      @wagons << wagon
    else
      p "Нельзя прицеплять вагоны на ходу. Сбросьте скорость"
    end
  end

# добавил проверку скорости
  def delete_wagons(vagons = 1)
    if @speed == 0
      @wagons -= vagons
    else
      p "Нельзя отцеплять вагоны на ходу. Сбросьте скорость"
    end
  end

  def stay?
    @speed == 0
  end

  def last_station?
    current_station == @route.stations.last
  end

  def first_station?
    current_station == @route.stations.first
  end

  protected

  #validate format with regular expr
  def validate_format(atr)
    raise TypeError, "Invalid FORMAT of identifical number(valid example 000-sd)" unless atr =~ VALID_NUMBER
  end

  def validate!
    validate_presence(@number)
    validate_length(@number)
    validate_format(@number)
  end
end
