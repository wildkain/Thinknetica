class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'PassengerTrain'
  end

  def add_wagons(wagon)
    return unless wagon.is_a?(PassengerWagon)
    super
  end
end
