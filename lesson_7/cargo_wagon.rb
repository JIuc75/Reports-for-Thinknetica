class CargoWagon < Wagon
  attr_reader :volume, :occupies_volume

  def initialize(number, volume, occupies_volume)
    super(number, 'cargo')
    @volume = volume
    @occupies_volume = 0
  end

  def available_volume
    volume - occupies_volume
  end

  def take_volume(volume)
    @occupies_volume += volume
  end

end
