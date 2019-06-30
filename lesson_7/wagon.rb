require_relative 'manufacture'

class Wagon
  include Manufacture
  attr_reader :type, :number, :number_of_seats, :volume, :occupies_volume

  def initialize(number, type)
    @number = number
    @type = type
  end

  def available_volume_and_place
    @volume - @occupies_volume
    @number_of_seats - @place
  end

  def take_volume(volume)
    @occupies_volume += volume
  end

end
