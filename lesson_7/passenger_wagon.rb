# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(number)
    super(number, 'passenger')
  end

  def take_the_place
    take_volume(1)
  end

  def take_volume(_volume = 1)
    super(1)
  end

  alias take_the_place take_volume
end
