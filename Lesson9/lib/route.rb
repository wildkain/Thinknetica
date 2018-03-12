class Route
  include InstanceCounter
  include Validation
  include Comparable
  extend Accessors

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

  def modify?
    return false if stations.count < 3
    true
  end

  protected

  def validate!
    raise 'Not a station' unless @stations.first.is_a?(Station) && @stations.last.is_a?(Station)
    raise 'Not unique points' if @stations.first.similar_to?(@stations.last)
  end
end
