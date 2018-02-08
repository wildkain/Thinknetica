class Train
  attr_reader :number, :type, :wagons
  attr_accessor :route

  def initialize(number, type, wagons)
    @number    = number
    @type      = type
    @wagons = wagons.to_i
    @speed = 0
  end

  # не смог придумать, как реализовать изменение скорости в одном методе
  # по-этому разделил на два
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
  end

  #избавился от puts, проверка на маршрут
  def current_station
   @current_station = @route.stations[@station_index] if @route
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
    @current_station.train_out(self)
    @station_index += 1 if @station_index
    @route.stations[@station_index].take_train(self)
  end

# добавил проверку на нахождение на начальной станции. изменил прибытие - убытие со станции.
  def move_backward
    return if first_station?
    @current_station.train_out(self)
    @station_index -= 1 if @station_index
    @route.stations[@station_index].take_train(self)
  end

# добавил проверку скорости
  def add_wagons(vagons = 1)
    if @speed == 0
      @wagons += vagons
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

  private

  def last_station?
    current_station == @route.stations.last
  end

  def first_station?
    current_station == @route.stations.first
  end

end
