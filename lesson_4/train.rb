class Train
  attr_reader :number, :type, :speed, :route, :wagons

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
  end

  def up_speed(speed)
    @speed += speed
  end

  def down_speed(speed)
    @speed -= speed
    @speed = 0 if speed.negative?
  end

  def add_wagon(wagon)
    return unless speed.zero?
    return unless attachable_wagon?(wagon)

    @wagons << wagon
  end

  def del_wagon(wagons)
    @wagons.delete(wagons) if @speed.zero?
  end

  def route=(route)
    @route = route
    @route.number_route
    @index_station = 0
    current_station.accept_train(self)
  end

  def forward
    return if next_station.nil?

    current_station.send_train(self)
    next_station.accept_train(self)
    @index_station += 1
  end

  def backward
    return if previous_station.nil?

    current_station.send_train(self)
    previous_station.accept_train(self)
    @index_station -= 1
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
