class PassengerWagon < Wagon
  attr_accessor :model, :places, :free_places, :busy_places

  def initialize(number, places)
    super
    @places = {}
    places = (1..places).to_a
    places.each { |val| @places[val] = "Empty"}
    @free_places = places
    @model = "Passenger"
  end

  def load_passenger(place_number)
    @places[place_number] = "Busy"
  end

  def away_passenger(place_number)
    @places[place_number] = "Empty"
  end

  def busy_places
    busy_places  = []
    @places.each {|key, value|  busy_places << key if value == "Busy" }
    busy_places
  end

  def free_places
    free_places = []
    @places.each {|key, value|  free_places << key if value == "Empty" }
    free_places
  end
end
