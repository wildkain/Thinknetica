class PassengerTrain < Train
 #child class of Train
 attr_reader :type

 def initialize(number)
 	super
 	@type  = "PassengerTrain"
 end

def add_wagons(wagon)

 	return if !passenger_wagon?(wagon)
 	super
 end

 def load_passengers
 end
 private

 def passenger_wagon?(wagon)
 	wagon.instance_of? PassengerWagon
 end

end