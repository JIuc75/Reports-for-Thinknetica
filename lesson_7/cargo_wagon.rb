class CargoWagon < Wagon

  def initialize(number, volume, occupies_volume)
    super(number, 'cargo')
    @volume = volume
    @occupies_volume = 0
  end

end
