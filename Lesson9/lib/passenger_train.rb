class PassengerTrain < Train
  validate :number, :presence
  validate :number, :formatt, Train::VALID_NUMBER

  def initialize(number)
    super
    @type = 'PassengerTrain'
  end

  def add_wagons(wagon)
    return unless wagon.is_a?(PassengerWagon)
    super
  end
end
