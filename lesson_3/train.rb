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

  def route(route)
    @route = route
    @index_station = 0
    current_station
  end

  def forward
    return if next_station.nil?
    current_station.accept_train(self)
    @route.stations[@index_station += 1]
    current_station
  end

  def backward
    current_station.send_train(self) if current_station
    @route.stations[@index_station -= 1] if @index_station.positive?
    current_station
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
