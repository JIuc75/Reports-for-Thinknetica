class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :start_station, :end_station, :stations

  def initialize(start_station, end_station)
    @stations = []
    @start_station = start_station
    @end_station = end_station
    @stations << @start_station << @end_station
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return if [first_station, last_station].include?(station)
    @stations.delete(station)
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end
end


class Train
  attr_reader :number, :type, :speed, :amount_of_wagons, :route

  def initialize(number, type, amount_wagons)
    @number = number
    @type = type
    @amount_wagons = amount_wagons
    @speed = 0
  end

  def up_speed(speed)
    @speed += speed
  end

  def down_speed(speed)
    @speed -= speed if speed.negative?
  end

  def add_wagons
    @amount_of_wagons += 1 if speed.zero?
  end

  def delete_wagon
    @amount_of_wagons -= 1 if amount_of_wagons.positive? && speed.zero?
  end

  def route=(route)
    @route = route
    @index_station = 0
    current_station.accept_train(self)
  end

  def forward
    return if next_station.nil?
    current_station.send_train(self)
    @index_station += 1
    next_station.accept_train(self)
  end

  def backward
    current_station.send_train(self)
    @index_station -= 1 if @index_station.positive?
    previous_station.accept_train(self)
  end

  def current_station
    @route.stations[@index_station]
  end

  def next_station
    @route.stations[@index_station + 1]
  end

  def previous_station
    @route.stations[@index_station - 1] if @index_station.positive?
  end

end
