require_relative 'manufacture'

class Wagon
  include Manufacture
  attr_reader :type, :number, :volume, :occupied_volume

  NOT_ENOUGH_SPACE = '!!!В вагоне больше нет места!!!'.freeze

  def initialize(number, volume, type)
    @number = number
    @type = type
    @volume = volume
    @occupied_volume = 0
  end

  def available_volume
    @volume - @occupied_volume
  end

  def take_volume(volume)
    raise NOT_ENOUGH_SPACE if @occupied_volume + volume > @volume

    @occupied_volume += volume
  end

end
