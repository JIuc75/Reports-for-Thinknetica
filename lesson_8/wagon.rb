require_relative 'manufacture'

class Wagon
  include Manufacture
  attr_reader :type, :number, :volume

  def initialize(number, type)
    @number = number
    @type = type
  end

  def available_volume
    @volume - @occupies_volume
  end

  def take_volume(volume)
    @occupies_volume += volume
  end

end
