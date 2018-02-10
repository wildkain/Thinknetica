class PassengerWagon
@@counter = 0

attr_reader :type, :id, :date
#child class of Wagon
def initialize
	@@counter +=1
	@type  = "Passenger"
	@id = @@counter
	@date = Time.now
end


def load_passengers

end

end