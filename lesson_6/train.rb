require_relative 'manufacture'
require_relative 'instance_counter'
require_relative 'validations'

class Train
  include Manufacture
  include InstanceCounter
  include Validations

  NUMBER_FORMAT = /^[\da-z]{3}-?[\da-z]{2}$/i
  ERROR_NUMBER_FORMAT = 'Неверный формат номера'.freeze

  attr_reader :number, :type, :speed, :route, :wagons

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @wagons = []
    validate!
    @@trains[number] = self
    register_instance
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
    @route.number
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

  protected

  def validate!
    raise ERROR_NUMBER_FORMAT if @number !~ NUMBER_FORMAT
  end

end
