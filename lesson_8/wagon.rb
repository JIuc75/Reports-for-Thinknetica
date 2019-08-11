require_relative 'manufacture'

class Wagon
  include Manufacture
  attr_reader :type, :number, :volume

  def initialize(number, type, volume)
    @number = number
    @type = type
    @occupied_volume = volume
  end

  def available_volume
    @volume - @occupies_volume
  end

  def take_volume(volume)
    if @occupied_volume + volume > @volume
      raise '!!!В вагоне больше нет места!!!'
    end

    @occupies_volume += volume
  end

end
