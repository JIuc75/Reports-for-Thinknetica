class CargoWagon < Wagon

  def initialize(number, volume)
    super(number, 'cargo')
    @volume = volume
    @occupies_volume = volume
  end

end
