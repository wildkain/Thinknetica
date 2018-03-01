class Route
  include InstanceCounter
  include Validator

  attr_accessor :stations

  def initialize(first_station, last_station)
    register_instance
    @stations = [first_station, last_station]
    validate!
  end


  def add_to_list(station)
    @stations.insert(-2, station)
  end


  def delete_station(station)
    @stations.delete(station)
  end

  def print_list
    @stations.each_with_index do |station, index|
      puts "#{index} -- #{station.name}"
    end
  end

  protected

  def validate!
    raise "Bad stations in the route" unless @stations.first.valid? || @stations.last.valid?
    true
  end

end
