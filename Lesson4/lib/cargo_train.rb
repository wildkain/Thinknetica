class CargoTrain < Train 
	attr_reader :type
	# child class of Train




def initialize(number)
	super
	@type = "CargoTrain"
end





def add_wagons(wagon)

 	return if !cargo_wagon?(wagon)
 	super
 end


private

  def cargo_wagon?(wagon)
    wagon.instance_of? CargoWagon
  end

end