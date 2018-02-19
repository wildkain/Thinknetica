class CargoTrain < Train
# child class of Train
  def initialize(number)
		super
		@type = "CargoTrain"
	end

  def add_wagons(wagon)
		return unless wagon.is_a?(CargoWagon)
		super
  end

end
