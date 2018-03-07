class Station
  include InstanceCounter
  include Validator

  attr_accessor :name, :trains

  @@stations = []

  def initialize(params)
    register_instance
    @name = params[:name]
    @trains = []
    @@stations << self
    validate!
  end

  def self.find_all
    @@stations
  end

  # take a train inside
  def take_train(train)
    @trains << train
  end

  def list_trains
    @trains.each { |train| yield(train) }
  end

  # depart trains from current station(instance)
  def train_out(train)
    @trains.delete(train)
  end

  def similar_to?(other)
    return true if name.casecmp(other.name).zero?
    false
  end

  protected

  def validate!
    validate_presence(@name)
    validate_length(@name)
  end
end
