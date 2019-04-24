class Station
  attr_accessor :name, :trains
  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def trains_type(type)
    @trains = type
  end

  def send_trains(train)
    @trains.delete(train)
  end

  def all_train
    @trains
  end
end

class Route
  attr_accessor :station
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations = station
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def all_station
    @stations
  end

  def first_station
    station.first
  end

  def last_station
    station.last
  end
end

class Train
  attr_accessor :number, :type, :speed, :amount_of_wagons, :route, :index_station
  def initialize(number, type, amount_wagons)
    @number = number
    @type = type
    @amount_wagons = amount_wagons
    @speed = 0
  end

  def up_speed
    @speed += 1
  end

  def down_speed
    @speed -= 1 if speed.nonzero?
  end

  def add_wagons
    @amount_of_wagons += 1 if speed.zero?
  end

  def delete_wagon
    @amount_of_wagons -= 1 if amount_of_wagons != 0 && speed.zero?
  end

  def amount_wagon
    @amount_of_wagons
  end

  def route_destination(route)
    @route = route
    @index_station = 0
    route
  end

  def forward
    @index_station += 1
  end

  def backward
    @index_station -= 1
  end

  def current_station
    @index_station
  end

  def next_station
    @index_station + 1
  end

  def previous_station
    @index_station - 1 if @index_station.nonzero?
  end
end
