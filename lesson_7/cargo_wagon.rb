class CargoWagon < Wagon

  alias occupies_volume take_volume

  def initialize(number, volume, occupies_volume)
    super(number, 'cargo')
    @volume = volume
    @occupies_volume = 0
  end

  def occupies_volume(volume)
    take_volume(volume)
  end

end
