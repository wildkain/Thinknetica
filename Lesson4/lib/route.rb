class Route
  attr_accessor :stations


  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end


  def add_to_list(station)
    @stations.insert(-2, station)
    p "Станция #{station.name}  добавлена в маршрут"
  end


  def delete_station(station)
    @stations.delete(station)
  end

  def print_list

    num = 0
    @stations.each do |station, num|
      puts station.name
      p num+=1
    end
  end

end
