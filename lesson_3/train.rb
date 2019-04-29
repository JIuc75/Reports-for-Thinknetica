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
    route.current_station.accept_train(self)
  end

  def forward
    @index_station += 1
  end

  def backward
    @index_station -= 1
  end

  def current_station
    route.stations[@index_station]
  end

  def next_station
    @route.stations[@index_station + 1]
  end

  def previous_station
    @route.stations[@index_station - 1]
  end
end
