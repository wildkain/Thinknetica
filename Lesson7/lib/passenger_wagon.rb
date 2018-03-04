class PassengerWagon < Wagon
  attr_accessor :model, :places, :free_places, :busy_places

  def initialize(number, places)
    super(number)
    @places = Hash[(1..places).map { |place| [place, 'Empty'] }]
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
    busy = @places.select {|key,value| value == "Busy" }
    busy.count
  end

  def free_places
    free_places = @places.select {|key,value| value == "Empty" }

    if block_given?
      yield(free_places)
    else
      free_places.count
    end
  end

end
