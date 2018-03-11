class Station
  include InstanceCounter
  include Validation
  include Accessors

  attr_accessor :name, :trains

  @@stations = []

  validate :name, :presence

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
end
