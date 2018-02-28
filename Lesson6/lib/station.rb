  class Station

  attr_accessor :name, :trains

  @@stations = []


  include InstanceCounter
  include Validator

  # #new инициализация параметров инстанса
  def initialize(params)

    register_instance
    @name = params[:name]
    validate!
    @trains = []
    @@stations << self
  end

  def self.find_all
    @@stations
  end


# принимаем поезд  - добавляем его в массив @trains интанса
  def take_train(train)
    @trains << train
  end

  def list_trains
     @trains.each { |train| puts "Номер поезда: #{train.number}--Тип:#{train.class}--Кол-во вагонов:#{train.wagons.size}" }
  end

  # группировка по типу поезда. принимает тип и группирует по нему с выводом количества.
  def trains_by_type(type)
    counter =  @trains.find_all {|train| train.type == type}
    if counter.count > 0
      p "В данный момент на станции #{@name} количество поездов с типом #{type} :  #{counter.count}"
    elsif @trains.empty?
      p "На станции вообще нет поездов"
  else
    p "На станции нет поездов с таким типом"
  end


  end
# удаляем поезд из массива @trains инстанса
  def train_out(train)
    @trains.delete(train)
  end


  def validate!
    validate_presence(@name)
    validate_length(@name)

  end
end
